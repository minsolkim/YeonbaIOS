//
//  SignUpViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 2/29/24.
//
import UIKit
import SnapKit
import Then
import Alamofire

class NicknameSettingViewController: UIViewController {
    
    let instructionLabel = UILabel().then {
        $0.text = "닉네임을 입력해 주세요."
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 24)
        $0.numberOfLines = 0
    }
    
    let instructionLabel2 = UILabel().then {
        $0.text = "닉네임은 한글, 영어, 숫자 모두 가능해요"
        $0.textColor = .darkGray
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 14)
        $0.numberOfLines = 0
    }
    
    let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임 입력"
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
    }
    let nicknameCheck = UIButton().then {
        $0.setTitle("중복확인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(nicknameCheckTapped), for: .touchUpInside)
    }
    let nicknameBool = UILabel().then {
        $0.text = "이미 사용중인 닉네임입니다."
        $0.textColor = .primary
        $0.textAlignment = .left
        $0.font = .pretendardSemiBold(size: 15)
        $0.isHidden = true
    }
    let nextButton = ActualGradientButton().then {
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 25
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()
        setupKeyboardDismissal()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "회원가입"
    }
    
    private func setupKeyboardDismissal() {
        // 키보드가 활성화된 상태에서 화면을 터치했을 때 키보드가 사라지도록 설정합니다.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupViews() {
        view.addSubviews(instructionLabel,instructionLabel2,nicknameTextField,nicknameCheck,nicknameBool,nextButton)
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        instructionLabel2.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        nicknameCheck.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.top)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(nicknameTextField.snp.trailing).offset(5)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        nicknameBool.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            make.leading.equalTo(nicknameTextField.snp.leading)
            
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-55)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    //MARK: - Actions
    @objc func backButtonTapped() {
        // 뒤로 가기 로직을 구현
        navigationController?.popViewController(animated: true)
    }
    @objc func nextButtonTapped() {
        guard let nickname = nicknameTextField.text, !nickname.isEmpty else {
            let alert = UIAlertController(title: "닉네임 입력", message: "닉네임을 입력해 주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        if nickname.count >= 8 {
            let alert = UIAlertController(title: "닉네임 길이 초과", message: "닉네임은 8자 이하여야 합니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        SignDataManager.shared.nickName = nickname
        let nextVC = GenderSelectionViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    //닉네임 중복확인
    @objc func nicknameCheckTapped() {
        guard let nickname = nicknameTextField.text else { return }

        // Validation for nickname
        let nicknamePattern = "^[a-zA-Z0-9가-힣]{1,8}$"
        let nicknamePredicate = NSPredicate(format: "SELF MATCHES %@", nicknamePattern)
        let isValidNickname = nicknamePredicate.evaluate(with: nickname)

        if !isValidNickname {
            nicknameBool.isHidden = false
            nicknameBool.numberOfLines = 0
            nicknameBool.text = "닉네임은 공백 없이 영어 대소문자, 한글, 숫자로 \n구성되어야 하며 최대 8자까지 가능합니다."
            return
        }
        
        let nicknameRequest = NicknameRequest(nickname: nickname)
        print(nicknameRequest)
        
        NetworkService.shared.signUpService.nicknameCheck(queryDTO: nicknameRequest) { response in
            switch response {
            case .success(let StatusResponse):
                if let data = StatusResponse.data {
                    if data.isUsedNickname {
                        print("닉네임 사용 불가능")
                        self.nicknameBool.isHidden = false
                        self.nicknameBool.text = "이미 사용중인 닉네임입니다."
                    } else {
                        print("닉네임 사용 가능")
                        self.nicknameBool.isHidden = false
                        self.nicknameBool.text = "사용 가능한 닉네임입니다."
                    }
                } else {
                    print("응답 데이터 없음")
                }
            case .requestErr(let StatusResponse):
                print("요청 에러: \(StatusResponse.message)")
            case .pathErr:
                print("경로 에러")
            case .serverErr:
                print("서버 에러")
            case .networkErr:
                print("네트워크 에러")
            case .failure:
                print("요청 실패")
            }
        }
    }


}

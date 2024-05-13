//
//  SignUpViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 2/29/24.
//
import UIKit
import SnapKit
import Then

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
        $0.font = UIFont.pretendardSemiBold(size: 16)
        $0.numberOfLines = 0
    }
    
    let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임 입력"
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 8
        $0.textAlignment = .center
        $0.borderStyle = .roundedRect
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
        // 키보드를 숨깁니다.
        view.endEditing(true)
    }
    
    private func setupViews() {
        view.addSubviews(instructionLabel,instructionLabel2,nicknameTextField,nextButton)
        
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
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
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
}

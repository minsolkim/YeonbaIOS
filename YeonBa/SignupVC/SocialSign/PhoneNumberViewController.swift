//
//  PhoneNumberViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 2/29/24.
//
import UIKit
import SnapKit
import Then
import Alamofire
import SwiftKeychainWrapper

class PhoneNumberViewController: UIViewController {
    var socialID: Int?
    var loginType: String?
    let instructionLabel = UILabel().then {
        $0.text = "전화번호를 입력해주세요."
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .pretendardBold(size: 26)
        $0.numberOfLines = 0
    }
    
    let instructionLabel2 = UILabel().then {
        $0.text = "가입여부에만 활용되며, 절대 노출되지 않아요."
        $0.textColor = .customgray3
        $0.textAlignment = .center
        $0.font = .pretendardMedium(size: 16)
        $0.numberOfLines = 0
    }
    
    let phoneNumberUnderlineView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let verificationCodeUnderlineView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let phoneNumberTextField = UITextField().then {
        $0.placeholder = "전화번호 입력"
        $0.keyboardType = .phonePad
        $0.borderStyle = .roundedRect
        $0.textAlignment = .left
        $0.keyboardType = .numberPad
        
    }
    
    let nextButton = ActualGradientButton().then {
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .systemGray
        $0.layer.cornerRadius = 30
        $0.isEnabled = false // 인증 완료 전까지 비활성화
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        $0.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupKeyboardDismissal()
        setupViews()
        
    }
    
    private func setupViews() {
        view.addSubviews(instructionLabel,instructionLabel2,phoneNumberUnderlineView,verificationCodeUnderlineView,phoneNumberTextField,nextButton)
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.equalToSuperview().inset(20)
        }
        
        instructionLabel2.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        
        phoneNumberTextField.borderStyle = .none
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel2.snp.top).offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        phoneNumberUnderlineView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom)
            make.leading.trailing.equalTo(phoneNumberTextField)
            make.height.equalTo(1)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    // MARK: Select RootViewController Function
    func changeRootViewController(rootViewController: UIViewController) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = BaseNavigationController(rootViewController: rootViewController)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        // 전화번호의 길이가 11자인지 검사합니다.
        guard phoneNumber.count == 11 else {
            return false
        }
        
        // 전화번호는 숫자로만 이루어져야 합니다.
        let phoneNumberCharacterSet = CharacterSet.decimalDigits
        guard phoneNumber.rangeOfCharacter(from: phoneNumberCharacterSet.inverted) == nil else {
            return false
        }
        
        // 모든 규칙을 통과한 경우 유효한 전화번호로 간주합니다.
        return true
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
    //MARK: -- Action
    //전송 버튼을 눌를 경우
    @objc func sendCodeButtonTapped() {
        guard let phoneNumber = phoneNumberTextField.text else {
            return
        }
        if isValidPhoneNumber(phoneNumber) {
            
        } else {
            // 전화번호가 유효하지 않은 경우, 사용자에게 알림 등을 표시할 수 있습니다.
            print("전화번호는 11자리의 숫자여야 합니다.")
        }
    }
    
    @objc func confirmButtonTapped() {
        // 인증번호 유효성 검사 통과 후
        verificationSuccessful()
    }
    
    private func verificationSuccessful() {
        // 인증 성공 시 '다음' 버튼을 활성화합니다.
        nextButton.isEnabled = true
        nextButton.backgroundColor = .systemBlue
    }
    // 토큰 가져오기
//    func retrieveAccessToken() -> String? {
//        return KeychainWrapper.standard.string(forKey: "accessToken")
//    }
    func getUserInfo() {
        let loginRequest = LoginRequest (
            socialId : SignDataManager.shared.socialId!,
            loginType : SignDataManager.shared.loginType!,
            phoneNumber :SignDataManager.shared.phoneNumber!
        )
        NetworkService.shared.loginService.login(bodyDTO: loginRequest) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                print("로그인 성공")
            default:
                print("로그인 실패")

            }
        }
    }
    
    func checkPhoneNumber() {
        guard let phoneNumber = phoneNumberTextField.text else {
            return
        }
        let phoneNumberRequest = PhoneNumberRequest(phoneNumber: phoneNumber)

        NetworkService.shared.signUpService.phoneNumberCheck(queryDTO: phoneNumberRequest) { response in
            switch response {
            case .success(let StatusResponse):
                if let data = StatusResponse.data {
                    if data.isUsedPhoneNumber {
                        print("전화번호 이미 존재")
                        self.showAlert(message: "전화번호가 이미 존재합니다.")
                    } else {
                        print("전화번호 사용 가능")
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
    @objc func nextButtonTapped() {
        guard let phoneNumber = phoneNumberTextField.text else {
            return
        }
        verificationSuccessful()
        checkPhoneNumber()
        if isValidPhoneNumber(phoneNumber) {
            // 전화번호가 유효한 경우
            if KeychainHandler.shared.accessToken.isEmpty {
                SignDataManager.shared.phoneNumber = phoneNumber
                
                let birthVC = BirthDateSettingViewController()
                navigationController?.pushViewController(birthVC, animated: true)
            } else {
                //유저가 존재할 경우
                getUserInfo()
                let tabVC = TabBarController()
                self.changeRootViewController(rootViewController: tabVC)
                
            }
        } else {
            // 전화번호가 유효하지 않은 경우
            showAlert(message: "전화번호는 11자리의 숫자여야 합니다.")
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

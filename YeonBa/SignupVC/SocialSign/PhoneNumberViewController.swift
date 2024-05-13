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
    func retrieveAccessToken() -> String? {
        return KeychainWrapper.standard.string(forKey: "accessToken")
    }
    func fetchData() {
        guard let phoneNumber = phoneNumberTextField.text else {
            return
        }
        // 각각의 필드값을 출력
        print("socialId: \(socialID ?? 0)")
        print("loginType: \(loginType ?? "")")
        print("phoneNumber: \(phoneNumber)")
        let endpoint = "https://api.yeonba.co.kr/users/login"
        socialID = SignDataManager.shared.socialId
        loginType = SignDataManager.shared.loginType
        let parameters: [String: Any] = [
            "socialId": socialID ?? 0,
            "loginType": loginType ?? "",
            "phoneNumber": phoneNumber
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let value):
                    if let httpResponse = response.response {
                        let statusCode = httpResponse.statusCode
                        print("Response status code: \(statusCode)")
                    }
                    if let json = value as? [String: Any] {
                        if let status = json["status"] as? String {
                            if status == "success" {
                                // Handle success case
                                if let data = json["data"] as? [String: Any],
                                   let accessToken = data["accessToken"] as? String,
                                   let refreshToken = data["refreshToken"] as? String {
                                    // Save tokens to Keychain
                                    let saveAccessToken = KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
                                    if saveAccessToken {
                                        print("AccessToken: \(accessToken)")
                                        print("Access token saved successfully.")
                                    } else {
                                        print("Failed to save access token.")
                                    }
                                    
                                    let saveRefreshToken = KeychainWrapper.standard.set(refreshToken, forKey: "refreshToken")
                                    if saveRefreshToken {
                                        print("RefreshToken: \(refreshToken)")
                                        print("Refresh token saved successfully.")
                                    } else {
                                        print("Failed to save refresh token.")
                                    }
                                } else {
                                    print("Failed to retrieve tokens from the response.")
                                }
                            } else {
                                
                                if let message = json["message"] as? String {
                                    print("Message: \(message)")
                                    // Show message to the user or take appropriate action
                                }
                            }
                        }
                    }
                    
                case .failure(let error):
                    print("Error sending POST request: \(error)")
                    // Handle failure case
                }
            }
    }
    @objc func nextButtonTapped() {
        guard let phoneNumber = phoneNumberTextField.text else {
            return
        }
        //유저가 존재할 경우
        fetchData()
        
        if isValidPhoneNumber(phoneNumber) {
            // 전화번호가 유효한 경우
            verificationSuccessful()
            
            if KeychainHandler.shared.accessToken.isEmpty {
                //유저가 존재하지 않을 경우
                SignDataManager.shared.phoneNumber = phoneNumber
                let birthVC = BirthDateSettingViewController()
                navigationController?.pushViewController(birthVC, animated: true)
                
            } else {
                //유저가 존재할 경우
                fetchData()
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

//
//  SignUpViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 2/29/24.
//
import UIKit
import KakaoSDKUser
import SnapKit
import Then
import AuthenticationServices

class SignUpViewController: UIViewController {
    var socialID: Int?
    var loginType: String?
    let logoLabel = UILabel().then {
        $0.text = "YeonBa"
        $0.font = UIFont.pretendardSemiBold(size: 60)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logoimage")
        $0.contentMode = .scaleAspectFit
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "연애는, 바로 지금, 연바"
        $0.font = UIFont.pretendardSemiBold(size: 26)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    let loginButton = UIButton().then {
        //$0.setTitle("로그인 하기", for: .normal)
        $0.setImage(UIImage(named: "kakaoLoginBtn"), for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.red, for: .normal)
        $0.layer.cornerRadius = 25
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
//    let signUpButton = UIButton().then {
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font: UIFont.systemFont(ofSize: 16),
//            .foregroundColor: UIColor.white,
//            .underlineStyle: NSUnderlineStyle.single.rawValue
//        ]
//        let attributedTitle = NSAttributedString(string: "가입하기", attributes: attributes)
//        $0.setAttributedTitle(attributedTitle, for: .normal)
//        $0.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
//    }
    
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.secondary?.cgColor, UIColor.primary?.cgColor]
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        layer.cornerRadius = 16
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.insertSublayer(gradientLayer, at: 0)
        setupViews()
        setupProviderLoginView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    func setupProviderLoginView() {
        let appleButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        appleButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.view.addSubview(appleButton)
        
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            
        }
    }
    
    private func setupViews() {
        
        view.addSubview(logoLabel)
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(200)
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().inset(40)
        }
        
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(logoLabel.snp.centerY)
            make.right.equalTo(logoLabel.snp.left).offset(10)
            make.width.height.equalTo(60)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(70)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        //        view.addSubview(signUpButton)
        //        signUpButton.snp.makeConstraints { make in
        //            make.top.equalTo(loginButton.snp.bottom).offset(20)
        //            make.centerX.equalToSuperview()
        //        }
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        
    }
    
    
}

// MARK: - Actions
extension SignUpViewController {
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName,.email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc func loginButtonTapped() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                guard let self = self else { return }
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")
                    self.loginType = "KAKAO"
                    // 사용자의 카카오 아이디 받아오기
                    self.fetchKakaoUserID()
                    // PhoneNumberViewController로 이동
                    self.navigateToPhoneNumberVC()
                    
                }
            }
        } else {
            // 카톡 설치되어있지 않으면 -> 카카오 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                guard let self = self else { return }
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    self.loginType = "KAKAO"
                    // 사용자의 카카오 아이디 받아오기
                    self.fetchKakaoUserID()
                    
                }
            }
        }
    }
    func fetchKakaoUserID() {
        UserApi.shared.me { [weak self] (user, error) in
            guard let self = self else { return }
            if let error = error {
                print("카카오 사용자 정보 가져오기 실패: \(error)")
            } else {
                if let id = user?.id {
                    self.socialID = Int(id)
                    print("카카오 사용자 아이디: \(id)")
                    // PhoneNumberViewController로 이동
                    self.navigateToPhoneNumberVC()
                }
            }
        }
    }
    
    func navigateToPhoneNumberVC() {
        let phonenumberVC = PhoneNumberViewController()
        SignDataManager.shared.socialId = self.socialID
        SignDataManager.shared.loginType = self.loginType
        print("소셜ID: \(String(describing: SignDataManager.shared.socialId))")
        print("소셜ID: \(String(describing: SignDataManager.shared.loginType))")
        phonenumberVC.socialID = self.socialID
        phonenumberVC.loginType = self.loginType
        navigationController?.pushViewController(phonenumberVC, animated: true)
        
    }
    
//    @objc func signUpButtonTapped() {
//        
//        let phonenumberVC = PhoneNumberViewController()
//        phonenumberVC.socialID = self.socialID
//        phonenumberVC.loginType = self.loginType
//        navigationController?.pushViewController(phonenumberVC, animated: true)
//    }
}

extension SignUpViewController:
    ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authString = String(data: authorizationCode, encoding: .utf8),
                let tokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authString: \(authString)")
                print("tokenString: \(tokenString)")
            }
            
            
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username)")
            print("password: \(password)")
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        //handle error.
    }
}






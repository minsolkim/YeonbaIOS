//
//  SplashViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 5/10/24.
//

import UIKit
import SnapKit
import Alamofire
import SwiftKeychainWrapper

class SplashViewController: UIViewController {
    let signUpViewController = SignUpViewController()
    let tabbarController = TabBarController()
    let homeViewController = HomeViewController()
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.secondary?.cgColor ?? UIColor.white, UIColor.primary?.cgColor ?? UIColor.white]
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        return layer
    }()
    
    private let firstLogo: UILabel = {
        let attributedText = NSMutableAttributedString(string: "연애는\n바로지금,")
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedText.length)) // 전체 텍스트의 글자색 변경
        attributedText.addAttribute(.font, value: UIFont.pretendardSemiBold(size: 50), range: NSRange(location: 0, length: attributedText.length)) // 전체 텍스트의 폰트 변경
        
        let label = UILabel()
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let secondLogo = UILabel().then {
        $0.text = "연바"
        $0.textColor = .white
        $0.font = .pretendardSemiBold(size: 60)
        $0.textAlignment = .left
    }
    
    private let LineImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        let image = UIImage(named: "line") // 이미지 이름에 따라 수정하세요
        $0.image = image
    }
    private let LogoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        let image = UIImage(named: "SplashLogo") // 이미지 이름에 따라 수정하세요
        $0.image = image
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = CGRect(x: 0, y: -UIApplication.shared.statusBarFrame.height, width: view.bounds.width, height: view.bounds.height + UIApplication.shared.statusBarFrame.height)
        setViews()
        branchProcessing()
        getUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: Select RootViewController Function
    func changeRootViewController(rootViewController: UIViewController) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = BaseNavigationController(rootViewController: rootViewController)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func branchProcessing() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5 ) {
            print("accesstoken:\(KeychainHandler.shared.accessToken)")
            //회원이 아닌 유저일 경우
            if KeychainHandler.shared.accessToken.isEmpty {
                //어세스 토큰이 없는 경우
                self.changeRootViewController(rootViewController: self.signUpViewController)
            } else { //이미 가입된 유저일 경우
                //어세스 토큰이 존재하는 경우
                self.changeRootViewController(rootViewController: self.tabbarController)
            }
        }
    }
    private func updateDeviceTokenOnServer(deviceToken: String) {
        guard let url = URL(string: "https://api.yeonba.co.kr/users/device-token") else { return }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(KeychainHandler.shared.accessToken)"
        ]
        
        let parameters: [String: Any] = ["deviceToken": deviceToken]
        
        AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let httpResponse = response.response, httpResponse.statusCode == 200 {
                        print("Device token updated successfully.")
                    } else {
                        print("Failed to update device token. Status code: \(response.response?.statusCode ?? 0)")
                        print("Response data: \(value)")
                    }
                case .failure(let error):
                    print("Error updating device token: \(error.localizedDescription)")
                }
            }
    }
    // MARK: Network Function
    func getUserInfo() {
        guard let socialId = SignDataManager.shared.socialId,
              let loginType = SignDataManager.shared.loginType,
              let phoneNumber = SignDataManager.shared.phoneNumber else {
            print("필수 데이터가 없습니다.")
            return
        }
        let loginRequest = LoginRequest (
            socialId : socialId,
            loginType : loginType,
            phoneNumber : phoneNumber
        )
        NetworkService.shared.loginService.login(bodyDTO: loginRequest) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                print("로그인 성공")
                
                // AccessToken 및 RefreshToken 저장
                KeychainHandler.shared.accessToken = data.accessToken
                KeychainHandler.shared.refreshToken = data.refreshToken
                let jwt = JWT(token: data.accessToken)
                if let userId = jwt?.userId {
                    KeychainHandler.shared.kakaoUserID = jwt?.userId ?? 0
                    print("유저 아이디\(KeychainHandler.shared.kakaoUserID)")
                } else {
                    
                }
                // AccessToken이 제대로 설정되었을 때에만 Authorization 헤더 설정
                if !data.accessToken.isEmpty {
                    NetworkService.shared.setAuthorizationHeader(token: data.accessToken)
                    let deviceToken = KeychainHandler.shared.deviceToken
                    self.updateDeviceTokenOnServer(deviceToken: deviceToken)
                    print("device token: \(KeychainHandler.shared.deviceToken)")
                    
                }
                
            default:
                print("로그인 실패")
                
            }
        }
    }
    
}

extension SplashViewController {
    func setViews() {
        view.addSubviews(firstLogo,secondLogo,LineImageView,LogoImageView)
        firstLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(30)
        }
        secondLogo.snp.makeConstraints { make in
            make.leading.equalTo(firstLogo.snp.leading)
            make.top.equalTo(firstLogo.snp.bottom)
        }
        LineImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        LogoImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.trailing.equalToSuperview().inset(50)
        }
    }
}

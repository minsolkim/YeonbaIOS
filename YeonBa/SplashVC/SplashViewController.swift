//
//  SplashViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 5/10/24.
//

import UIKit
import SnapKit
import Alamofire

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // getUserInfo()
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = CGRect(x: 0, y: -UIApplication.shared.statusBarFrame.height, width: view.bounds.width, height: view.bounds.height + UIApplication.shared.statusBarFrame.height)
    }
    // MARK: Select RootViewController Function
    func changeRootViewController(rootViewController: UIViewController) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = BaseNavigationController(rootViewController: rootViewController)
        navigationController?.popToRootViewController(animated: true)
    }
    func branchProcessing() {
        if KeychainHandler.shared.accessToken.isEmpty {
            //어세스 토큰이 없는 경우
            self.changeRootViewController(rootViewController: self.signUpViewController)
        } else {
            //어세스 토큰이 존재하는 경우
            self.changeRootViewController(rootViewController: self.tabbarController)
        }
    }
    // MARK: Network Function
//    func getUserInfo() {
//        NetworkService.shared.loginService.login(bodyDTO: LoginRequest) { [weak self] response in
//            guard let self = self else { return }
//            switch response {
//            case .success(let data):
//                guard let data = data.data else { return }
//                
//                
//            }
//            
//            
//        }
//    }
    
}

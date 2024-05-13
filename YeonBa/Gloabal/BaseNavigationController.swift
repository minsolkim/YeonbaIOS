//
//  BaseNavigationController.swift
//  YeonBa
//
//  Created by 김민솔 on 5/4/24.
//

import UIKit

class BaseNavigationController: UINavigationController {
    static func makeNavigationController(rootViewController: UIViewController) -> BaseNavigationController {
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        return navigationController
    }
    private var backButtonImage: UIImage? {
        return UIImage(named: "back2")?.withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: -12.0, bottom: -5.0, right: 0.0))
    }
    private var backButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        // backButton하단에 표출되는 text를 안보이게 설정
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0.0)]
        
        return backButtonAppearance
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearance()
        navigationItem.hidesBackButton = false
    }
    func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backButtonAppearance = backButtonAppearance
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
    }
    
    
}

//
//  tabBarController.swift
//  YeonBa
//
//  Created by 김민솔 on 2/29/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.setupViewControllers()
        setupTabBarAppearance()
    }
    private func setupViewControllers() {
        let homeViewController = HomeViewController()
        let searchViewController = SearchViewController()
        let collectViewController = CollectViewController()
        let chattingViewController = ChattingViewController()
        let settingViewController = SettingViewController()
        
        homeViewController.tabBarItem = UITabBarItem(title: "홈화면", image: UIImage(named: "Home"), selectedImage: UIImage(named: "FillHome"))
        searchViewController.tabBarItem = UITabBarItem(title: "찾아보기", image: UIImage(named: "Search"), selectedImage: UIImage(named: "FillSearch"))
        collectViewController.tabBarItem = UITabBarItem(title: "모아보기", image: UIImage(named: "Collect"), selectedImage: UIImage(named: "FillCollect"))
        chattingViewController.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(named: "Chatting"), selectedImage: UIImage(named: "FillChatting"))
        settingViewController.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "Setting"), selectedImage: UIImage(named: "FillSetting"))
        viewControllers = [homeViewController, searchViewController, collectViewController, chattingViewController, settingViewController].map { BaseNavigationController(rootViewController: $0) }
    }
    private func setupTabBarAppearance() {
        tabBar.isTranslucent = false
        setTabBarColors(
            backgroundColor: .white,
            tintColor: UIColor.primary!,
            unselectedItemTintColor: .gray
        )
    }
    
    private func setTabBarColors(backgroundColor: UIColor, tintColor: UIColor, unselectedItemTintColor: UIColor) {
        tabBar.backgroundColor = backgroundColor
        tabBar.tintColor = tintColor
        tabBar.unselectedItemTintColor = unselectedItemTintColor
    }
    
}


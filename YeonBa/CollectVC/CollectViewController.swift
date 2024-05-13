//
//  CollectViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 2/29/24.
//

import UIKit
import SnapKit
import Tabman
import Pageboy
import Alamofire

class CollectViewController: TabmanViewController {    
    private var viewcontrollers : Array<UIViewController> = []
    private var tabbar =  TMBar.ButtonBar().then {
        $0.backgroundView.style = .clear
        $0.layout.transitionStyle = .snap
        $0.layout.contentMode = .fit
        $0.buttons.customize { (button) in
            button.selectedTintColor = UIColor.primary
            button.tintColor = .gray
        }
        $0.indicator.weight = .custom(value: 3)
        $0.indicator.tintColor = UIColor.primary
    }
    private lazy var containerView =  UIView().then {
        $0.backgroundColor = .clear
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers()
        setConstraints()
        tabbar.dataSource = self
        dataSource = self
       
    }
    func setViewControllers() {
        let sendVC = SendCupidViewController()
        let receiveVC = RecieveCupidViewController()
        let favoriteVC = FavoriteCupidViewController()
        viewcontrollers.append(contentsOf: [sendVC,favoriteVC,receiveVC])
    }
    func setConstraints() {
        addBar(tabbar, dataSource: self, at: .custom(view: containerView, layout: nil))
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}
extension CollectViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewcontrollers.count
    }
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewcontrollers[index]
    }
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let titles = ["보낸화살","즐겨찾는 이성","받은 화살"]
        return TMBarItem(title: titles[index])
    }
}

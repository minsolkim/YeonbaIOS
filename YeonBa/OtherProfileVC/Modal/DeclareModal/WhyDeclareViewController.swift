//
//  WhyDeclareViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 3/28/24.
//

import UIKit
import SnapKit

protocol WhyDeclareViewControllerDelegate: AnyObject {
    func whydidSelectedRowAt(indexPath: Int)
}

final class WhyDeclareViewController: UIViewController {
    private var selectedCellIndex: IndexPath?

    weak var delegate: WhyDeclareViewControllerDelegate?
    private let customTransitioningDelegate = WhyDeclareDelegate()
    private let currentMode: WhyMode
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: .zero)
        navigationBar.isTranslucent = false
        return navigationBar
    }()
    private let findButton = ActualGradientButton().then {
        $0.setTitle("신고 완료", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 15)
        $0.setTitleColor(.customgray, for: .normal)
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
    }
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.register(WhyDeclareTableViewCell.self,
                           forCellReuseIdentifier: "modalCell")
        return tableView
    }()
    
    init(passMode: WhyMode) {
        self.currentMode = passMode
        super.init(nibName: nil, bundle: nil)
        
        setupModalStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupModalStyle() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .coverVertical
        transitioningDelegate = customTransitioningDelegate
    }
    // 선택된 위치가 없을 때 finishButton을 비활성화하는 메서드
    private func updateFinishButtonState() {
        if currentMode.title == nil {
            findButton.isEnabled = false
            findButton.setTitleColor(.customgray4, for: .normal)
        } else {
            findButton.isEnabled = true
            findButton.setTitleColor(.white, for: .normal)
        }
    }
    private func setupInitialView() {
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
    }
    private func setupNavigationBar() {
        let navigationItem = UINavigationItem(title: "신고하기")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                     target: self,
                                                     action: #selector(dismissView))
        navigationBar.items = [navigationItem]
    }

    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = view.bounds.height / 12
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
    @objc private func doneTapped() {
        delegate?.whydidSelectedRowAt(indexPath: selectedCellIndex!.row)
        dismissView()
    }
}
//MARK: -- 신고하기 UITableViewDelegate,UITableViewDataSource

extension WhyDeclareViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "modalCell",
                                                       for: indexPath) as? WhyDeclareTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: .none)
        }
        let mode = WhyMode.allCases.filter { $0 != .empty }[indexPath.row]
        // 이미지를 설정하여 셀에 전달
        cell.setup(label: mode.title ?? "")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        selectedCellIndex = indexPath
        updateFinishButtonState()
        //dismissView()
    }
    
}

// MARK: 신고하기 Setup Layout
extension WhyDeclareViewController {
    private func setupView() {
        setupInitialView()
        setupNavigationBar()
        setupTableView()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        view.addSubview(tableView)
        view.addSubview(findButton)
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview()
            
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(findButton.snp.top)
        }
        findButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(43)
        }
        
    }
}

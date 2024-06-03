//
//  ChattingRoomViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 5/15/24.
//

import UIKit
import SnapKit
import Then

class ChattingRoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var messagesDateString = "yyyy년 MM월 dd일"
    var messages: [ChatMessage] = [] // 채팅 데이터를 저장할 배열
    // 날짜별로 섹션화된 채팅 데이터
    var chatSections: [ChatSection] = []
    var sendView = SendView()
    //MARK: - UI Components
    lazy var tableView = UITableView(frame: .zero, style: .grouped).then{
        $0.register(MyMessageCell.self, forCellReuseIdentifier: "MyMessageCell")
        $0.register(OtherMessageCell.self, forCellReuseIdentifier: "OtherMessageCell")
        $0.dataSource = self
        $0.delegate = self
        $0.separatorStyle = .none // 셀 사이의 구분선을 제거
        // 자동 높이 계산 활성화
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 50 // 셀 높이의 적절한 추정치
        $0.sectionFooterHeight = 0
    }
    //MARK: - Actions
    @objc func backButtonTapped() {
        // 뒤로 가기 로직을 구현
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "변우석"
        addSubViews()
        configUI()
        loadChatData() // 가짜 데이터 로드 함수
        tabBarController?.tabBar.isTranslucent = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    
    }
    
    // MARK: - UI Layout
    func addSubViews(){
        view.addSubview(sendView)
        view.addSubview(tableView)
    }
    func configUI() {
        sendView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalTo(sendView.snp.top)
        }
    }
    
    func loadChatData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let dates = ["2024년 05월 15일", "2024년 06월 10일"].compactMap { dateFormatter.date(from: $0) }
        
        // 가짜 데이터 생성
        for date in dates {
            messages = [
                ChatMessage(sender: .other, message: "안녕 ㅋㅋㅋ", date: date),
                ChatMessage(sender: .other, message: "밥은 먹었니? 뭐하고 있니", date: date),
                ChatMessage(sender: .me, message: "그래 안녕하세요 밥 아직 안먹음 ㅋ ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ", date: date),
                ChatMessage(sender: .me, message: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋ아니 안녕못하는데? ㅋ ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ9 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ9 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ ㅋㅋ", date: date)
            ]
            let section = ChatSection(date: date, messages: messages)
            chatSections.append(section)
        }
        
        tableView.reloadData()
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatMessage = messages[indexPath.row]
        
        switch chatMessage.sender {
        case .me:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageCell", for: indexPath) as! MyMessageCell
            cell.messageLabel.text = chatMessage.message
            // 날짜 설정, 셀 스타일링 등
            return cell
        case .other:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherMessageCell", for: indexPath) as! OtherMessageCell
            cell.messageLabel.text = chatMessage.message
            cell.profileImageView.image = UIImage(named: "woosuck")
            // 날짜 설정, 셀 스타일링 등
            return cell
        }
    }
    // UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return chatSections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatSections[section].messages.count
    }
    
    // 섹션 헤더 뷰
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .white
        
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        label.text = dateFormatter.string(from: chatSections[section].date)
        label.font = UIFont.pretendardRegular(size: 13)
        label.textColor = UIColor.darkGray
        header.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(header.snp.top).offset(19)
            make.bottom.equalTo(header.snp.bottom).offset(-19)
            make.centerX.equalTo(header)
        }
        
        return header
    }
}

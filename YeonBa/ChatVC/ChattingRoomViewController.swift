import UIKit
import SnapKit
import Then

struct ChatMessage {
    var sender: Sender
    var message: String
    var date: Date
}

// 채팅 메시지를 날짜별로 분류한 구조체
struct ChatSection {
    var date: Date
    var messages: [ChatMessage]
}

enum Sender {
    case me
    case other
}

class ChattingRoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    var messagesDateString = "yyyy년 MM월 dd일"
    var messages: [ChatMessage] = [] // 채팅 데이터를 저장할 배열
    // 날짜별로 섹션화된 채팅 데이터
    var chatSections: [ChatSection] = []
    
    //MARK: - UI Components
    let titleLabel = UILabel().then{
        $0.text = "박원빈"
        $0.font = UIFont.pretendardMedium(size: 18)
    }
    let backButton = UIButton(type: .system).then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .light)
        let image = UIImage(named: "BackButton")
        $0.setImage(image, for: .normal)
        $0.tintColor = UIColor.black
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    let galleryButton = UIButton().then {
        $0.setImage(UIImage(named: "GalleryIcon"), for: .normal) // 갤러리 아이콘 이미지 설정
        $0.contentMode = .scaleAspectFit
    }
    
    let messageTextField = UITextField().then {
        $0.placeholder = "메시지 보내기"
        $0.borderStyle = .none
        $0.backgroundColor = .gray2
        $0.textColor = .customgray4
        $0.font = UIFont.pretendardRegular(size: 13)
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
        $0.textAlignment = .left
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40)) // sendButton의 width와 동일하게 설정
        $0.rightViewMode = .always
    }
    let sendButton = UIButton().then {
        $0.setImage(UIImage(named: "SendIcon"), for: .normal) // 전송 아이콘 이미지 설정
        $0.contentMode = .scaleAspectFit
        }
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
        addSubViews()
        configUI()
        loadChatData() // 가짜 데이터 로드 함수
        
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - UI Layout
    func addSubViews(){
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(galleryButton)
        view.addSubview(messageTextField)
        view.addSubview(sendButton)
        view.addSubview(tableView)
    }
    func configUI() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(21)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.centerX.equalToSuperview()
        }
        galleryButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-62)
            make.width.height.equalTo(26) // 아이콘 크기
        }
        messageTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-55)
            make.height.equalTo(40)
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-35)
            make.centerY.equalTo(messageTextField.snp.centerY)
            make.width.height.equalTo(20) // 아이콘 크기
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(21)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-105)
        }
        
        
    }
    
    func loadChatData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let dates = ["2024년 04월 03일", "2024년 04월 04일"].compactMap { dateFormatter.date(from: $0) }
        
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
            cell.profileImageView.image = UIImage(named: "GuideGoodImage1")
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

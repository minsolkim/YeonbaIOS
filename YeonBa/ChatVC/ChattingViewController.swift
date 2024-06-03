import UIKit
import SnapKit
import Then
import Alamofire

class ChattingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var chatModel: [ChatListResponse] = []

    // MARK: - UI Components
    let bodyStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 24
    }
    let heartImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "Bigheart")
    }
    let contentLabel = UILabel().then {
        $0.text = "진행중인 채팅방이 없습니다.\n마음에 드는 이성을 찾아 보세요!"
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont.pretendardSemiBold(size: 20)
    }
    lazy var tableView = UITableView().then {
        $0.register(ChattingListCell.self, forCellReuseIdentifier: "ChattingListCell")
        $0.dataSource = self
        $0.delegate = self
    }
    let activityIndicator = UIActivityIndicatorView(style: .large).then {
        $0.hidesWhenStopped = true
    }

    // MARK: - Actions
    @objc func backButtonTapped() {
        // 뒤로 가기 로직을 구현
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "채팅"
        addSubViews()
        configUI()
        updateChat()
    }

    func reloadData() {
        updateChat()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }

    // MARK: - Empty UI Layout
    func addEmptySubviews() {
        view.addSubview(bodyStackView)
        [self.heartImage, self.contentLabel]
            .forEach(self.bodyStackView.addArrangedSubview(_:))
    }
    
    func configEmptyUI() {
        self.bodyStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: - UI Layout
    private func addSubViews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    private func configUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func removeEmptySubviews() {
        self.bodyStackView.removeFromSuperview()
        self.heartImage.removeFromSuperview()
        self.contentLabel.removeFromSuperview()
    }

    // MARK: - Networking
    private func updateChat() {
        activityIndicator.startAnimating()
        
        NetworkService.shared.chatService.chatList() { response in
            switch response {
            case .success(let statusResponse):
                guard let data = statusResponse.data else { return }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.chatModel = data
                    self.tableView.reloadData()
                    
                    if data.isEmpty {
                        self.addEmptySubviews()
                        self.configEmptyUI()
                    } else {
                        self.removeEmptySubviews()
                    }
                }
            default:
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    print("데이터 안들어옴")
                }
            }
        }
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingListCell.identifier, for: indexPath) as? ChattingListCell else {
            return UITableViewCell()
        }
        let post = chatModel[indexPath.row]
        cell.configure(with: post)
        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust cell height accordingly
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // '나가기' 액션
        let leaveAction = UIContextualAction(style: .destructive, title: "나가기") { action, view, completionHandler in
            // 나가기 로직을 구현
            completionHandler(true)
        }
        leaveAction.backgroundColor = .primary
        
        // '차단' 액션
        let blockAction = UIContextualAction(style: .normal, title: "차단") { action, view, completionHandler in
            // 차단 로직을 구현
            completionHandler(true)
        }
        blockAction.backgroundColor = .gray2

        let configuration = UISwipeActionsConfiguration(actions: [leaveAction, blockAction])
        return configuration
    }

    // 아이템 클릭
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRoomId = chatModel[indexPath.row].id
        let chattingRoomViewController = ChattingRoomViewController()
        chattingRoomViewController.roomId = selectedRoomId
        let chatUserName = chatModel[indexPath.row].partnerName
        let chatUserProfile = chatModel[indexPath.row].partnerProfileImageUrl
        chattingRoomViewController.chatUserName = chatUserName
        chattingRoomViewController.partnerProfileImageUrl = chatUserProfile
        navigationController?.pushViewController(chattingRoomViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

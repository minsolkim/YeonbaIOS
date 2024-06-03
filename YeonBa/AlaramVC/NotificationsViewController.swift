import UIKit
import SnapKit
import Then

class NotificationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - UI Components
    var notifications : [Notification] = []
    
    lazy var tableView = UITableView().then {
        $0.register(ArrowNotificationCell.self, forCellReuseIdentifier: "ArrowNotificationCell")
        $0.register(ChatAcceptanceCell.self, forCellReuseIdentifier: "ChatAcceptanceCell")
        $0.register(ChatRequestCell.self, forCellReuseIdentifier: "ChatRequestCell")
        $0.dataSource = self
        $0.delegate = self
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "알림"
        addSubViews()
        configUI()
        fetchNotifications(page: 0)
    }

    // MARK: - UI Layout
    private func addSubViews(){
        view.addSubview(tableView)
    }
    private func configUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
    // MARK: - Networking
    func fetchNotifications(page: Int) {
        let requestDTO = NotificationPageRequest(page: page)
        NetworkService.shared.notificationService.NotificationList(queryDTO: requestDTO) { response in
            switch response {
            case .success(let statusResponse):
                if let data = statusResponse.data {
                    DispatchQueue.main.async {
                        self.notifications = data.nofications
                        self.tableView.reloadData()
                    }
                }
            case .requestErr(let statusResponse):
                print("요청 에러: \(statusResponse.message)")
            case .pathErr:
                print("경로 에러")
            case .serverErr:
                print("서버 에러")
            case .networkErr:
                print("네트워크 에러")
            case .failure:
                print("실패")
            }
        }
    }

            
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notification = notifications[indexPath.row]
        
        switch notification.notificationType {
        case "ARROW_RECEIVED":
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArrowNotificationCell", for: indexPath) as! ArrowNotificationCell
            cell.configure(with: notification)
            return cell
        case "CHAT_REQUESTED":
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRequestCell", for: indexPath) as! ChatRequestCell
            cell.configure(with: notification)
            return cell
        case "CHAT_REQUEST_ACCEPTED":
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatAcceptanceCell", for: indexPath) as! ChatAcceptanceCell
            cell.configure(with: notification) 
            return cell
        default:
            return UITableViewCell()
        }
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust cell height accordingly
    }
}

// MARK: - Extensions
// Extend UITableViewCell to create a custom cell

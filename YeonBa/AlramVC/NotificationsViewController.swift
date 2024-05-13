import UIKit
import SnapKit
import Then

class NotificationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - UI Components
    let titleLabel = UILabel().then{
        $0.text = "알림"
        $0.font = UIFont.pretendardMedium(size: 18)
    }
    let backButton = UIButton(type: .system).then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .light)
        let image = UIImage(named: "BackButton")
        $0.setImage(image, for: .normal)
        $0.tintColor = UIColor.black
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    lazy var tableView = UITableView().then {
        $0.register(ArrowNotificationCell.self, forCellReuseIdentifier: "ArrowNotificationCell")
        $0.register(ChatAcceptanceCell.self, forCellReuseIdentifier: "ChatAcceptanceCell")
        $0.register(ChatRequestCell.self, forCellReuseIdentifier: "ChatRequestCell")
        $0.dataSource = self
        $0.delegate = self
    }
    
    //MARK: - Actions
    @objc func backButtonTapped() {
        // 뒤로 가기 로직을 구현
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configUI()
    }

    // MARK: - UI Layout
    private func addSubViews(){
        view.addSubview(tableView)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
    }
    private func configUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(21)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.centerX.equalToSuperview()
        }
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of notification types for simplicity
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArrowNotificationCell", for: indexPath) as! ArrowNotificationCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatAcceptanceCell", for: indexPath) as! ChatAcceptanceCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRequestCell", for: indexPath) as! ChatRequestCell
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

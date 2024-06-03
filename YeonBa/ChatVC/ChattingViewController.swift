import UIKit
import SnapKit
import Then


class ChattingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    //MARK: - Actions
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
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    

    // MARK: - UI Layout
    private func addSubViews(){
        view.addSubview(tableView)
        /*view.addSubview(bodyStackView)
        [self.heartImage, self.contentLabel]
          .forEach(self.bodyStackView.addArrangedSubview(_:))*/
    }
    private func configUI() {
        /*self.bodyStackView.snp.makeConstraints {make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }*/
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of notification types for simplicity
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChattingListCell", for: indexPath) as! ChattingListCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChattingListCell", for: indexPath) as! ChattingListCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChattingListCell", for: indexPath) as! ChattingListCell
            return cell
        default:
            return UITableViewCell()
        }
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust cell height accordingly
    }
    //스와이프 관련
    //글자색, 구분선 추가 불가
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // '나가기' 액션
        let leaveAction = UIContextualAction(style: .destructive, title: "나가기") { action, view, completionHandler in
            // 나가기 로직을 구현
            completionHandler(true)
        }
        leaveAction.backgroundColor = .red
        
        // '차단' 액션
        let blockAction = UIContextualAction(style: .normal, title: "차단") { action, view, completionHandler in
            // 차단 로직을 구현
            completionHandler(true)
        }
        blockAction.backgroundColor = .customgray4

        let configuration = UISwipeActionsConfiguration(actions: [leaveAction, blockAction])
        return configuration
    }
    //아이템 클릭
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let ChattingRoomViewController = ChattingRoomViewController()
            navigationController?.pushViewController(ChattingRoomViewController, animated: true)
            // 선택된 셀의 선택을 해제합니다.
            tableView.deselectRow(at: indexPath, animated: true)
        }
}

// MARK: - Extensions
// Extend UITableViewCell to create a custom cell

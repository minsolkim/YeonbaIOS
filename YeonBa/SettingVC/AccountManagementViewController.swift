import UIKit
import SwiftKeychainWrapper

class AccountManagementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        // Auto Layout 설정
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        self.navigationItem.title = "계정 관리"
    }

    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "휴면계정 전환"
        case 1:
            cell.textLabel?.text = "서비스 탈퇴"
        case 2:
            cell.textLabel?.text = "로그아웃"
        default:
            cell.textLabel?.text = "Unknown"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    // UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            presentHumanMemberSwitchAlert()
        case 1:
            presentServiceWithdrawalAlert()
        case 2:
            presentServiceWithLogout()
        default:
            print("Selected row at \(indexPath.row)")
        }
    }

    // 휴면계정 전환 팝업
    func presentHumanMemberSwitchAlert() {
        let alert = UIAlertController(title: "휴먼회원 전환", message: "휴먼 회원으로 전환 시 앱 내에서 프로필이 노출되지 않습니다. 또한 모든 채팅방이 종료됩니다. 휴먼회원으로 전환하시겠습니까?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "전환하기", style: .destructive) { action in
            print("휴먼 회원으로 전환 처리")
        }
        alert.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    func presentServiceWithdrawalAlert() {
       let alert = UIAlertController(title: "서비스 탈퇴 확인", message: "탈퇴 후 24시간 지나야 재가입이 가능합니다. 탈퇴 후 24시간 내 등록은 시 계정 정보가 유지됩니다.", preferredStyle: .alert)
       let confirmAction = UIAlertAction(title: "탈퇴하기", style: .destructive) { action in
           // 서비스 탈퇴 로직 구현
           print("서비스 탈퇴 처리")
       }
       alert.addAction(confirmAction)
       
       let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
       alert.addAction(cancelAction)
       
       present(alert, animated: true, completion: nil)
   }
    func presentServiceWithLogout() {
        let alert = UIAlertController(title: "서비스 로그아웃 확인", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "로그아웃", style: .destructive) { action in
//            KeychainHandler.shared.clearTokens()
            let signupVC = SignUpViewController()
            self.navigationController?.pushViewController(signupVC, animated: true)
            print("로그아웃 처리")
        }
        alert.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

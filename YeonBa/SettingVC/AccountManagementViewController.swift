import UIKit
import Alamofire

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
            presentLogoutConfirmation()
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
    
    // 서비스 탈퇴 팝업
    func presentServiceWithdrawalAlert() {
        let alert = UIAlertController(title: "서비스 탈퇴 확인", message: "탈퇴 후 24시간 지나야 재가입이 가능합니다. 탈퇴 후 24시간 내 등록은 시 계정 정보가 유지됩니다.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "탈퇴하기", style: .destructive) { action in
            print("서비스 탈퇴 처리")
            self.deleteUserAccount { success in
                DispatchQueue.main.async {
                    if success {
                        self.handleSuccessfulAccountDeletion()
                    } else {
                        self.presentErrorAlert(message: "계정 탈퇴에 실패했습니다. 다시 시도해 주세요.")
                    }
                }
            }
        }
        alert.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    func presentErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func handleSuccessfulAccountDeletion() {
        KeychainHandler.shared.accessToken = ""
        let signupVC = SignUpViewController()
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    // 로그아웃 확인 팝업
    func presentLogoutConfirmation() {
        let alert = UIAlertController(title: "로그아웃", message: "정말로 로그아웃 하시겠습니까?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "로그아웃하기", style: .destructive) { action in
            print("로그아웃 처리")
            KeychainHandler.shared.accessToken = ""
            let signupVC = SignUpViewController()
            self.navigationController?.pushViewController(signupVC, animated: true)
        }
        
        alert.addAction(logoutAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension AccountManagementViewController {
    func deleteUserAccount(completion: @escaping (Bool) -> Void) {
        let url = "https://api.yeonba.co.kr/users"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(KeychainHandler.shared.accessToken)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .delete, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    print("Account deleted successfully")
                    completion(true)
                } else {
                    print("Failed to delete account")
                    completion(false)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}

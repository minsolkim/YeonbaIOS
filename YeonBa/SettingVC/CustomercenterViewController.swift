import UIKit
import SnapKit
import Then

class CustomercenterViewController: UIViewController {
    
    private let emailLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.text = "앱 내에서 불편한 사항이 있을 시\n 123alsth@naver.com 연락 바랍니다."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupLayout()
    }
    private func setupNavigationBar() {
        navigationItem.title = "고객 센터"
    }
    private func setupLayout() {
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

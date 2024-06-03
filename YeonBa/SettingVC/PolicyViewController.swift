import UIKit
import SnapKit

class PolicyViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutViews()
    }

    private func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "이용 약관 및 개인정보 보호 정책"

        textView.isEditable = false
        textView.text = """
        여기에 이용 약관 내용을 입력하세요.
        긴 텍스트의 예:
        본 이용약관(이하 '약관')은 회사(이하 '회사')와 이용 고객(이하 '회원') 사이의 회사가 제공하는 서비스의 이용조건 및 절차, 회원과 회사의 권리, 의무, 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.
        """
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .black

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(textView)
    }

    private func layoutViews() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }

        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

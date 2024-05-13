import UIKit
import SnapKit
import Then

class SettingViewController: UIViewController {

    // MARK: - UI Components
    private let scrollview = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let imageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        let image = UIImage(named: "profilering") // 이미지 이름에 따라 수정하세요
        $0.image = image
    }
    private let nameLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "연바" // 원하는 이름으로 수정
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 24) 
    }
    let nameLabel2 = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Today"
        $0.textAlignment = .center
        $0.textColor = .black // 원하는 색상으로 설정하세요
    }
    private let horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    private let button1 = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("프로필 수정하기", for: .normal)
        $0.layer.borderWidth = 2.0 // 테두리 두께
        $0.layer.borderColor = UIColor.black.cgColor // 테두리 색상
        $0.layer.cornerRadius = 20.0 // 테두리 둥글기 반지름
        $0.setTitleColor(UIColor.black, for: .normal) // 텍스트 색상
        $0.setImage(UIImage(named: "profile")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .black
        $0.contentHorizontalAlignment = .center // 버튼1 이미지를 가로로 가운데 정렬
    }
    private let button2 = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("남은 화살 수", for: .normal)
        $0.layer.cornerRadius = 20.0 // 테두리 둥글기 반지름
        $0.backgroundColor = .primary
        $0.setTitleColor(UIColor.white, for: .normal) // 텍스트 색상
        $0.setImage(UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .white
        $0.contentHorizontalAlignment = .center // 버튼2 이미지를 가로로 가운데 정렬
    }
    private let bottomView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configUI()
        setupActions()
    }
    
    //MARK: - UI Layout
    func addSubviews() {
        view.addSubview(scrollview)
        scrollview.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameLabel2)
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(button1)
        horizontalStackView.addArrangedSubview(button2)
        contentView.addSubview(bottomView)
    }
    
    func configUI() {
        //snapkit 라이브러리
        scrollview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(850)
            $0.top.bottom.equalToSuperview().inset(70) // 모든 UI 요소를 아래로 100 포인트 내립니다.
        }
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).offset(-20)
            make.width.height.equalTo(150)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        nameLabel2.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(10) // 이름 레이블 옆에 10 포인트 간격으로 설정
            make.centerY.equalTo(nameLabel) // 이름 레이블과 수직 정렬
        }
            
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel2.snp.bottom).offset(22)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
            
        let views = (0..<8).map { _ in UIView() }
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .gray2
        bottomView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview() // 수직 스택 뷰의 상단과 하단을 부모 뷰에 맞춥니다.
            make.leading.trailing.equalToSuperview() // 수직 스택 뷰의 좌우를 부모 뷰에 맞춥니다.
        }
        
        bottomView.snp.makeConstraints { make in
               make.top.equalTo(button1.snp.bottom).offset(20)
               make.leading.trailing.equalToSuperview()
               make.height.equalTo(700)
           }
        
        let labelTitles = ["지인 만나지 않기", "알림 설정", "계정 관리", "차단 관리", "화살 충전", "고객 센터", "이용 약관/개인정보 취급 방침", "공지 사항"]
        let buttonTitles = ["버튼 1", "버튼 2", "버튼 3", "버튼 4", "버튼 5", "버튼 6", "버튼 7", "버튼 8"]


            views.enumerated().forEach { index, view in
                let label = UILabel()
                let title = labelTitles[index]
                label.text = title
                label.textColor = .black
                label.backgroundColor = .gray2
                view.addSubview(label)

                label.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.leading.equalToSuperview().offset(20)
                    make.top.equalToSuperview().offset(index * 80)
                    make.width.equalTo(393)
                    make.height.equalTo(200)
                }

                
                let button = UIButton()
                let image = UIImage(named: "allow")
                button.setImage(image, for: .normal)
                button.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
                button.tag = index // 태그를 사용하여 어떤 버튼이 눌렸는지 식별

                view.addSubview(button)

                button.snp.makeConstraints { make in
                    make.trailing.equalToSuperview().offset(10)
                    make.centerY.equalToSuperview()
                    make.width.equalTo(80)
                    make.height.equalTo(40)
                }
            }

            }

            

    func setupActions() {
        button1.addTarget(self, action: #selector(handleProfileEditTap), for: .touchUpInside)
    }
    
    @objc func handleProfileEditTap() {
        let profileEditViewController = ProfileEditViewController()
        navigationController?.pushViewController(profileEditViewController, animated: true)
    }

           
    @objc func buttonTapped(sender: UIButton) {
        switch sender.tag {
        case 0:
            let viewController = NomeetingViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let viewController = NotificationsettingsViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 2:
            let viewController = AccountManagementViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 3:
            let viewController = BlockingmanagementViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 4:
            let viewController = ArrowchargingViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 5:
            let viewController = CustomercenterViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 6:
            let viewController = PolicyViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 7:
            let viewController = NoticeViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
            
            
            



        }
        
    
    
    

import UIKit
import SnapKit
import Then
import Kingfisher

class ProfileEditViewController: UIViewController {
    // Scroll view to contain all content for scrolling
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let photoSectionLabel = UILabel().then {
        $0.text = "최소 2장의 사진을 등록해주세요."
        $0.font = UIFont.pretendardRegular(size: 14)
        $0.textColor = .black
    }

    private let photoScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }

    private let photoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
    }

    private let addPhotoImageViews = (0..<3).map { _ in UIImageView().then {
        $0.backgroundColor = .lightGray
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        $0.image = UIImage(named: "Addpicture")
    }}

    private let aboutMeLabel = UILabel().then {
        $0.text = "About Me"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }

    private let infoFields = ["키", "목소리", "사는 지역", "체형", "MBTI"].map { title in
        UIButton().then {
            $0.setTitle(title, for: .normal)
            $0.backgroundColor = .white  // 버튼 배경색을 하얗게 설정
            $0.layer.borderColor = UIColor.gray.cgColor  // 버튼 테두리를 회색으로 설정
            $0.layer.borderWidth = 1  // 테두리 두께 설정
            $0.layer.cornerRadius = 8  // 둥근 모서리 반경 설정
            $0.setTitleColor(.black, for: .normal)  // 버튼 내 텍스트 색상 설정
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.snp.makeConstraints { make in  // 버튼의 높이를 51로 설정
                make.height.equalTo(51)
            }
        }
    }


    private let preferenceLabel = UILabel().then {
        $0.text = "Preference"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }

    private let preferenceFields = ["선호하는 동물상", "선호하는 지역", "선호하는 목소리", "선호하는 나이대", "선호하는 체형", "선호하는 MBTI"].map { title in
        UIButton().then {
            $0.setTitle(title, for: .normal)
            $0.backgroundColor = .white  // 동일하게 하얀 배경
            $0.layer.borderColor = UIColor.gray.cgColor  // 회색 테두리
            $0.layer.borderWidth = 1  // 테두리 두께
            $0.layer.cornerRadius = 8  // 둥근 모서리
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(.black, for: .normal)  // 텍스트 색상
            $0.snp.makeConstraints { make in  // 높이 설정
                make.height.equalTo(51)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupNavigationBar()
        configurePhotoPicker()  // 사진 선택기 구성
        setupContentLayout()    // 컨텐츠 레이아웃 구성
    }

    private func setupNavigationBar() {
        navigationItem.title = "프로필 수정"
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }

        setupContentLayout()
    }

    private func setupContentLayout() {
        // 스택 뷰 생성 및 설정
        let stackView = UIStackView(arrangedSubviews: [
            photoSectionLabel,
            photoScrollView,
            aboutMeLabel
        ] + infoFields + [
            preferenceLabel
        ] + preferenceFields)

        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    private func configurePhotoPicker() {
        contentView.addSubview(photoScrollView)
        photoScrollView.addSubview(photoStackView)

        photoScrollView.snp.makeConstraints { make in
            make.top.equalTo(photoSectionLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }

        photoStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(photoScrollView)
        }

        addPhotoImageViews.forEach { imageView in
            photoStackView.addArrangedSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 150, height: 150))
            }
        }
    }
}

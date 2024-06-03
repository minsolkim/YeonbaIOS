import UIKit
import SnapKit
import Then
import Kingfisher

class ProfileEditViewController: UIViewController, UIViewControllerTransitioningDelegate, HeightEditViewControllerDelegate,VoiceEditViewControllerDelegate, LivingAreaViewControllerDelegate, BodyEditViewControllerDelegate, FaceEditViewControllerDelegate, MbtiEditViewControllerDelegate, AnimalPreferenceViewControllerDelegate, RegionPreferenceViewControllerDelegate, VoicePreferenceViewControllerDelegate, BodyTypePreferenceViewControllerDelegate, MBTIPreferenceViewControllerDelegate{
    
    func didSelectMBTI1(_ type: String) {
        if let mbtiButton = preferenceFields.first(where: { $0.titleLabel?.text == "선호하는 MBTI" }) {
            mbtiButton.setTitle(type, for: .normal)
        }
       
    }
    
    func didSelectBodyType1(_ type: String) {
        if let bodyButton = preferenceFields.first(where: { $0.titleLabel?.text == "선호하는 체형" }) {
            bodyButton.setTitle(type, for: .normal)
        }
    }
    
    func voicePreferenceSelected(_ voiceType: String) {
        if let voiceButton = preferenceFields.first(where: { $0.titleLabel?.text == "선호하는 목소리" }) {
            voiceButton.setTitle(voiceType, for: .normal)
        }
    }
    
    func didSelectRegionPreference(_ area: String) {
        if let areaButton = preferenceFields.first(where: { $0.titleLabel?.text == "선호하는 지역" }) {
            areaButton.setTitle(area, for: .normal)
        }
    }
    
    func didSelectFaceType1(_ type: String) {
        if let faceTypeButton = preferenceFields.first(where: { $0.titleLabel?.text == "선호하는 얼굴상" }) {
            faceTypeButton.setTitle(type, for: .normal)
        }
    }

    
    
    func didSelectMBTI(_ type: String) {
        if let mbtiButton = infoFields.first(where: { $0.titleLabel?.text == "MBTI" }) {
            mbtiButton.setTitle(type, for: .normal)
        }
       
    }

    
    func didSelectFaceType(_ type: String) {
        if let faceTypeButton = infoFields.first(where: { $0.titleLabel?.text == "얼굴상" }) {
            faceTypeButton.setTitle(type, for: .normal)
        }
    }
    

    
    
    func didSelectHeight(_ height: Int) {
        let heightButton = infoFields[0] 
        heightButton.setTitle("\(height)cm", for: .normal)
    }

   
    
    func voiceSelected(_ voiceType: String) {
        if let voiceButton = infoFields.first(where: { $0.titleLabel?.text == "목소리" }) {
            voiceButton.setTitle(voiceType, for: .normal)
        }
    }
    


    func didSelectLivingArea(_ area: String) {
        if let areaButton = infoFields.first(where: { $0.titleLabel?.text == "사는 지역" }) {
            areaButton.setTitle(area, for: .normal)
        }
    }
    
    func didSelectBodyType(_ type: String) {
        if let bodyButton = infoFields.first(where: { $0.titleLabel?.text == "체형" }) {
            bodyButton.setTitle(type, for: .normal)
        }
    }

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

    private let infoFieldTitles = ["키", "목소리", "사는 지역", "체형", "얼굴상", "MBTI"]
    private var infoFields: [UIButton] = []


    private let preferenceLabel = UILabel().then {
        $0.text = "Preference"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupNavigationBar()
        setupInfoFields()  // 정보 필드 설정
        setupPreferenceFields()
        configurePhotoPicker()  // 사진 선택기 구성
        setupContentLayout()  // 컨텐츠 레이아웃 구성
        setupNavigationBarButton()
    }


    private func setupInfoFields() {
        infoFields = infoFieldTitles.enumerated().map { index, title in
            let button = UIButton().then {
                $0.setTitle(title, for: .normal)
                $0.backgroundColor = .white
                $0.layer.borderColor = UIColor.gray.cgColor
                $0.layer.borderWidth = 1
                $0.layer.cornerRadius = 8
                $0.setTitleColor(.black, for: .normal)
                $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
                $0.snp.makeConstraints { make in  // 버튼의 높이를 51로 설정
                    make.height.equalTo(51)
                }
                $0.tag = index
                $0.addTarget(self, action: #selector(infoButtonTapped(_:)), for: .touchUpInside)
            }
            return button
        }
    }

    

    @objc private func infoButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let heightEditVC = HeightEditViewController()
            heightEditVC.delegate = self
            heightEditVC.modalPresentationStyle = .pageSheet
            present(heightEditVC, animated: true)
        case 1:
            let voiceEditVC = VoiceEditViewController()
            voiceEditVC.delegate = self
            voiceEditVC.modalPresentationStyle = .pageSheet
            present(voiceEditVC, animated: true)
        case 2:
            let livingareaEditVC = LivingAreaViewController()
            livingareaEditVC.delegate = self
            livingareaEditVC.modalPresentationStyle = .pageSheet
            present(livingareaEditVC, animated: true)
        case 3:
            let bodyEditVC = BodyEditViewController()
            bodyEditVC.delegate = self
            bodyEditVC.modalPresentationStyle = .pageSheet
            present(bodyEditVC, animated: true)
        case 4:
            let faceEditVC = FaceEditViewController()
            faceEditVC.delegate = self
            faceEditVC.modalPresentationStyle = .pageSheet
            present(faceEditVC, animated: true)
        case 5:
            let mbtiEditVC = MbtiEditViewController()
            mbtiEditVC.delegate = self
            mbtiEditVC.modalPresentationStyle = .pageSheet
            present(mbtiEditVC, animated: true)
            
        default:
            break
        }
    }

    private let preferenceFieldstitle = ["선호하는 얼굴상", "선호하는 지역", "선호하는 목소리", "선호하는 나이대", "선호하는 체형", "선호하는 MBTI"]
    private var preferenceFields: [UIButton] = []
                
    private func setupPreferenceFields() {
        preferenceFields = preferenceFieldstitle.enumerated().map { index, title in
            let button = UIButton().then {
                $0.setTitle(title, for: .normal)
                $0.backgroundColor = .white
                $0.layer.borderColor = UIColor.gray.cgColor
                $0.layer.borderWidth = 1
                $0.layer.cornerRadius = 8
                $0.setTitleColor(.black, for: .normal)
                $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
                $0.snp.makeConstraints { make in  // 버튼의 높이를 51로 설정
                    make.height.equalTo(51)
                }
                $0.tag = index
                $0.addTarget(self, action: #selector(preferenceButtonTapped(_:)), for: .touchUpInside)
            }
            return button
        }
    }

    @objc private func preferenceButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let animalPreferenceVC = AnimalPreferenceViewController()
            animalPreferenceVC.delegate = self
            animalPreferenceVC.modalPresentationStyle = .pageSheet
            present(animalPreferenceVC, animated: true)
        case 1:
            let regionPreferenceVC = RegionPreferenceViewController()
            regionPreferenceVC.delegate = self
            regionPreferenceVC.modalPresentationStyle = .pageSheet
            present(regionPreferenceVC, animated: true)
        case 2:
            let voicePreferenceVC = VoicePreferenceViewController()
            voicePreferenceVC.delegate = self
            voicePreferenceVC.modalPresentationStyle = .pageSheet
            present(voicePreferenceVC, animated: true)
            
            
        case 4:
            let bodyTypePreferenceVC = BodyTypePreferenceViewController()
            bodyTypePreferenceVC.delegate = self
            bodyTypePreferenceVC.modalPresentationStyle = .pageSheet
            present(bodyTypePreferenceVC, animated: true)
        case 5:
            let MBTIPreferenceVC = MBTIPreferenceViewController()
            MBTIPreferenceVC.delegate = self
            MBTIPreferenceVC.modalPresentationStyle = .pageSheet
            present(MBTIPreferenceVC, animated: true)
            
            
            
        default:
            break
        }
    }


 


    private func navigateToViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
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
    
    private func setupNavigationBarButton() {
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }

    @objc private func doneButtonTapped() {
        print("완료 버튼이 눌렸습니다.")
    }
}


//
//  MyFavoriteListViweController.swift
//  YeonBa
//
//  Created by jin on 4/10/24.
//
import UIKit
import SnapKit
import Then


class MyFavoriteListViweController: UIViewController {
    let locations = ["서울", "경기도", "인천", "부산", "대전", "광주", "대구", "울산", "강원도", "충북", "충남", "전북", "전남", "경북", "경남", "세종", "제주"]
    private var voiceViewMode: SignVoiceMode = .empty
    private var bodyViewMode: SignWeightMode = .empty
    private var animalViewMode: AnimalMode = .empty
    private var mbtiViewMode: MbtiMode = .empty
    private var locationViewMode: SignLocationMode = .empty
    private var ageViewMode: String = "20~25세"
    private var tallViewMode: String = "170~175cm"
    // MARK: - UI Components
    
    let headerLabel = UILabel().then {
        $0.text = "선호하는 조건을 골라 주세요."
        $0.textColor = .black
        $0.font = UIFont.pretendardSemiBold(size: 26)
    }
    let contentLabel = UILabel().then {
        $0.text = "매칭을 위해 필수 단계입니다."
        $0.textColor = .customgray4
        $0.font = UIFont.pretendardMedium(size: 16)
    }
    private let verticalStackview = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .top
        $0.spacing = 10
    }
    
    private let animalView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.customgray2?.cgColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let animalLabel = UILabel().then {
        $0.text = "선호하는 동물 상이 어떻게 되세요?"
        $0.textColor = UIColor.gray
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textAlignment = .center
    }
    private let animalChoiceBtn = UIButton().then {
        $0.setImage(UIImage(named: "nextBtn"), for: .normal)
    }
    private let locationView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.customgray2?.cgColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let locationLabel = UILabel().then {
        $0.text = "상대방의 선호하는 지역이 어떻게 되세요?"
        $0.textColor = UIColor.gray
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textAlignment = .center
    }
    private let locationChoiceBtn = UIButton().then {
        $0.setImage(UIImage(named: "nextBtn"), for: .normal)
    }
    private let voiceView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.customgray2?.cgColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let voiceLabel = UILabel().then {
        $0.text = "선호하는 음역대는 어떻게 되세요?"
        $0.textColor = UIColor.gray
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textAlignment = .center
    }
    private let voiceChoiceBtn = UIButton().then {
        $0.setImage(UIImage(named: "nextBtn"), for: .normal)
    }
    private let ageView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.customgray2?.cgColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let ageLabel = UILabel().then {
        $0.text = "선호하는 나이대가 어떻게 되세요?"
        $0.textColor = UIColor.gray
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textAlignment = .center
    }
    private let ageChoiceBtn = UIButton().then {
        $0.setImage(UIImage(named: "nextBtn"), for: .normal)
    }
    private let bodyView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.customgray2?.cgColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let bodyLabel = UILabel().then {
        $0.text = "선호하는 체형이 어떻게 되세요?"
        $0.textColor = UIColor.gray
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textAlignment = .center
    }
    private let bodyChoiceBtn = UIButton().then {
        $0.setImage(UIImage(named: "nextBtn"), for: .normal)
    }
    private let mbtiView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.customgray2?.cgColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let mbtiLabel = UILabel().then {
        $0.text = "선호하는 MBTI가 어떻게 되세요?"
        $0.textColor = UIColor.gray
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textAlignment = .center
    }
    private let mbtiChoiceBtn = UIButton().then {
        $0.setImage(UIImage(named: "nextBtn"), for: .normal)
    }
    
    private let tallView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.customgray2?.cgColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    private let tallLabel = UILabel().then {
        $0.text = "선호하는 키가 어떻게 되세요?"
        $0.textColor = UIColor.gray
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textAlignment = .center
    }
    private let tallChoiceBtn = UIButton().then {
        $0.setImage(UIImage(named: "nextBtn"), for: .normal)
    }
    
    let nextButton = ActualGradientButton().then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()
        configUI()
        tapGesture()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "나의 선호조건"
    }
    private func setupViews() {
        view.addSubviews(headerLabel,contentLabel,nextButton,verticalStackview)
        verticalStackview.addArrangedSubview(animalView)
        animalView.addSubviews(animalLabel,animalChoiceBtn)
        verticalStackview.addArrangedSubview(locationView)
        locationView.addSubviews(locationLabel,locationChoiceBtn)
        verticalStackview.addArrangedSubview(voiceView)
        voiceView.addSubviews(voiceLabel,voiceChoiceBtn)
        verticalStackview.addArrangedSubview(ageView)
        ageView.addSubviews(ageLabel,ageChoiceBtn)
        verticalStackview.addArrangedSubview(bodyView)
        bodyView.addSubviews(bodyLabel,bodyChoiceBtn)
        verticalStackview.addArrangedSubview(mbtiView)
        mbtiView.addSubviews(mbtiLabel,mbtiChoiceBtn)
        verticalStackview.addArrangedSubview(tallView)
        tallView.addSubviews(tallLabel,tallChoiceBtn)
    }
    func configUI() {
        
        headerLabel.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            make.leading.equalToSuperview().offset(20)
        }
        contentLabel.snp.makeConstraints{make in
            make.top.equalTo(headerLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
        }
        verticalStackview.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        animalView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview()
        }
        animalLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        animalChoiceBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
        }
        locationView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview()
        }
        locationLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        locationChoiceBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
        }
        voiceView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview()
        }
        voiceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        voiceChoiceBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
        }
        ageView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview()
        }
        ageLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        ageChoiceBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
        }
        bodyView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview()
        }
        bodyLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        bodyChoiceBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
        }
        mbtiView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview()
        }
        mbtiLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        mbtiChoiceBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
        }
        tallView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview()
        }
        tallLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        tallChoiceBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
        }
        nextButton.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-55)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(56)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    func tapGesture() {
        animalView.isUserInteractionEnabled = true
        let animalGesture = UITapGestureRecognizer(target: self, action: #selector(showAnimalModal))
        animalView.addGestureRecognizer(animalGesture)
        
        locationView.isUserInteractionEnabled = true
        let locationGesture = UITapGestureRecognizer(target: self, action: #selector(showLocationModal))
        locationView.addGestureRecognizer(locationGesture)
        
        voiceView.isUserInteractionEnabled = true
        let voiceGesture = UITapGestureRecognizer(target: self, action: #selector(showVoiceModal))
        voiceView.addGestureRecognizer(voiceGesture)
        
        ageView.isUserInteractionEnabled = true
        let ageGesture = UITapGestureRecognizer(target: self, action: #selector(showAgeModal))
        ageView.addGestureRecognizer(ageGesture)
        
        bodyView.isUserInteractionEnabled = true
        let bodyGesture = UITapGestureRecognizer(target: self, action: #selector(showBodyModal))
        bodyView.addGestureRecognizer(bodyGesture)
        
        mbtiView.isUserInteractionEnabled = true
        let mbtiGesture = UITapGestureRecognizer(target: self, action: #selector(showMbtiModal))
        mbtiView.addGestureRecognizer(mbtiGesture)
        
        tallView.isUserInteractionEnabled = true
        let tallGesture = UITapGestureRecognizer(target: self, action: #selector(showTallModal))
        tallView.addGestureRecognizer(tallGesture)
    }
    
    private func showAlertForMissingData() {
        let alertController = UIAlertController(title: "경고", message: "필수 정보를 모두 입력해주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    //MARK: - Actions
    @objc func backButtonTapped() {
        // 뒤로 가기 로직을 구현
        dismiss(animated: true, completion: nil)
    }
    
    @objc func nextButtonTapped() {
        guard voiceViewMode != .empty,
              bodyViewMode != .empty,
              animalViewMode != .empty,
              mbtiViewMode != .empty,
              locationViewMode != .empty,
              ageViewMode != nil,
              tallViewMode != nil else {
            showAlertForMissingData()
            return
        }
        
        // 모든 조건이 충족되면 다음 화면으로 이동합니다.
        let nextVC = VoiceRecordingViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func showLocationModal() {
        let locationModalVC = FavoriteLocationViewController(passMode: locationViewMode)
        locationModalVC.modalPresentationStyle = .pageSheet
        locationModalVC.delegate = self
        self.present(locationModalVC, animated: true)
    }
    @objc func showVoiceModal() {
        let voiceVC = FavoriteVoiceViewController(passMode: voiceViewMode)
        voiceVC.delegate = self
        self.present(voiceVC, animated: true)
    }
    @objc func showBodyModal() {
        let bodyVC = FavoriteBodyViewController(passMode: bodyViewMode)
        bodyVC.delegate = self
        self.present(bodyVC, animated: true)
    }
    @objc func showAnimalModal() {
        let animalVC = FavoriteAnimalViewController(passMode: animalViewMode)
        animalVC.delegate = self
        self.present(animalVC, animated: true)
    }
    @objc func showMbtiModal() {
        let mbtiVC = FavoriteMbtiViewController(passMode: mbtiViewMode)
        mbtiVC.delegate = self
        self.present(mbtiVC, animated: true)
    }
    @objc func showAgeModal() {
        let ageVC = AgeViewController()
        ageVC.delegate = self
        self.present(ageVC, animated: true)
    }
    @objc func showTallModal() {
        let tallVC = TallViewController()
        tallVC.delegate = self
        self.present(tallVC, animated: true)
    }
}
//MARK: -- 지역 delegate
extension MyFavoriteListViweController: FavoriteLocationViewControllerDelegate {
    func locationSelectedRowAt(indexPath: Int) {
        guard let mode = SignLocationMode(rawValue: indexPath) else { return }
        locationViewMode = mode
        locationLabel.text = mode.title // 라벨 텍스트 변경
        SignDataManager.shared.preferredArea = locationLabel.text
    }
}
//MARK: -- 음성 delegate
extension MyFavoriteListViweController: FavoriteVoiceViewControllerDelegate {
    func voiceSelectedRowAt(indexPath: Int) {
        guard let mode = SignVoiceMode(rawValue: indexPath) else { return }
        
        voiceViewMode = mode
        voiceLabel.text = mode.title // 라벨 텍스트 변경
        SignDataManager.shared.preferredVocalRange = voiceLabel.text
    }
}
//MARK: -- 체중 delegate
extension MyFavoriteListViweController: FavoriteBodyDelegate {
    func weightSelectedRowAt(indexPath: Int) {
        guard let mode = SignWeightMode(rawValue: indexPath) else { return }
        bodyViewMode = mode
        bodyLabel.text = mode.title // 라벨 텍스트 변경
        SignDataManager.shared.preferredBodyType = bodyLabel.text
    }
}
//MARK: -- 동물상 delegate
extension MyFavoriteListViweController: FavoriteAnimalViewControllerDelegate {
    func animalSelected(_ mode: AnimalMode) {
        animalViewMode = mode
        animalLabel.text = mode.title // 라벨 텍스트 변경
        SignDataManager.shared.preferredAnimal = animalLabel.text
    }
}
//MARK: -- mbti delegate
extension MyFavoriteListViweController: FavoriteMbtiViewControllerDelegate {
    func mbtiSelected(_ mode: MbtiMode) {
        mbtiViewMode = mode
        mbtiLabel.text = mode.title // 라벨 텍스트 변경
        SignDataManager.shared.preferredMbti = mbtiLabel.text
    }
}
//MARK: -- age delegate
extension MyFavoriteListViweController: AgeViewControllerDelegate {
    func favoriteAgeSelected(_ mode: String) {
        let ageComponents = mode.components(separatedBy: "~")
        
        // lowerBound와 upperBound가 적절하게 분리되었는지 확인
        guard ageComponents.count == 2,
              let lowerBound = Int(ageComponents[0].trimmingCharacters(in: .whitespaces)),
              let upperBound = Int(ageComponents[1].trimmingCharacters(in: .whitespaces)) else {
            // 올바른 형식이 아니면 에러 처리 또는 디폴트 값 할당
            print("잘못된 나이 형식입니다.")
            return
        }
        print("하향나이 : \(lowerBound)")
        print("상향나이 : \(upperBound)")
        // lowerBound와 upperBound를 적절한 속성에 할당
        SignDataManager.shared.preferredAgeLowerBound = lowerBound
        SignDataManager.shared.preferredAgeUpperBound = upperBound
        
        // 라벨 텍스트 변경
        ageLabel.text = mode
    }
}

//MARK: -- tall delegate
extension MyFavoriteListViweController: TallViewControllerDelegate {
    func favoriteTallSelected(_ mode: String) {
        //tallLabel.text = mode // 라벨 텍스트 변경
        let tallComponents = mode.components(separatedBy: "~")
        
        // lowerBound와 upperBound가 적절하게 분리되었는지 확인
        guard tallComponents.count == 2,
              let lowerBound = Int(tallComponents[0].trimmingCharacters(in: .whitespaces)),
              let upperBound = Int(tallComponents[1].trimmingCharacters(in: .whitespaces)) else {
            // 올바른 형식이 아니면 에러 처리 또는 디폴트 값 할당
            print("잘못된 키 형식입니다.")
            return
        }
        print("하향키 : \(lowerBound)")
        print("상향키 : \(upperBound)")
        // lowerBound와 upperBound를 적절한 속성에 할당
        SignDataManager.shared.preferredHeightLowerBound = lowerBound
        SignDataManager.shared.preferredHeightUpperBound = upperBound
        
        // 라벨 텍스트 변경
        tallLabel.text = mode
    }
}

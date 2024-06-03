
import UIKit
import SnapKit
import Then
import Alamofire

class AnalysisSyncResultViewController: UIViewController {
    
    var confidence1 = 0.0
    var confidence2 = 0.0
    
    // MARK: - UI Components
    let selfieImage = UIImageView().then{
        $0.image = SignDataManager.shared.selfieImage
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    let profileImage1 = UIImageView().then{
        $0.image = SignDataManager.shared.selectedImages[0]
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    let profileImage2 = UIImageView().then{
        $0.image = SignDataManager.shared.selectedImages[1]
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    let text1 = UILabel().then{
        $0.text = "연방님의 유사도는"
        $0.font = UIFont.pretendardExtraBold(size: 32)
        $0.textColor = .black // 검정색으로 설정
    }
    let text2 = UILabel().then{
        $0.text = "40%에요!"
        $0.font = UIFont.pretendardExtraBold(size: 32)
        $0.textColor = .black // 검정색으로 설정
    }
    let explainText = UILabel().then{
        $0.text = "업로드한 사진과 실제 얼굴이 달라요\nAI 포토샵으로 유사도를 높일 수 있어요!"
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textColor = UIColor.gray
    }
    
    let selfieBtn = ActualGradientButton().then {
        $0.setTitle("셀카 다시찍기", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(reSelfieBtnTapped), for: .touchUpInside)
    }
    let aiBtn = ActualGradientButton().then {
        $0.setTitle("AI 포토샵 하러가기", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(aiBtnTapped), for: .touchUpInside)
    }
    
    let startBtn = ActualGradientButton().then {
        $0.setTitle("연바 시작하기", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(startBtnTapped), for: .touchUpInside)
    }
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "사진 앨범"
    }
    // MARK: - Actions
    @objc func aiBtnTapped() {
        let aiVC = AiPhotoshopViewController()
        navigationController?.pushViewController(aiVC, animated: true)
    }
    @objc func reSelfieBtnTapped() {
        let guideVC = GuideViewController()
        navigationController?.pushViewController(guideVC, animated: true)
    }
    @objc func startBtnTapped() {
        let dataManager = SignDataManager.shared
        let signUpRequest = SignUpRequest (
            socialId: dataManager.socialId!,
            loginType: dataManager.loginType!,
            gender: dataManager.gender!,
            phoneNumber: dataManager.phoneNumber!,
            birth: dataManager.birthDate!,
            nickname: dataManager.nickName!,
            height: dataManager.height,
            bodyType: dataManager.bodyType!,
            job: dataManager.job!,
            activityArea: dataManager.activityArea!,
            mbti: dataManager.mbti!,
            vocalRange: dataManager.vocalRange!,
            profilePhotos: dataManager.profilePhotos,
            photoSyncRate: dataManager.confidence,
            lookAlikeAnimal: dataManager.lookAlikeAnimal!,
            preferredAnimal: dataManager.preferredAnimal!,
            preferredArea: dataManager.preferredArea!,
            preferredVocalRange: dataManager.preferredVocalRange!,
            preferredAgeLowerBound: dataManager.preferredAgeLowerBound,
            preferredAgeUpperBound: dataManager.preferredAgeUpperBound,
            preferredHeightLowerBound: dataManager.preferredHeightLowerBound!,
            preferredHeightUpperBound: dataManager.preferredHeightUpperBound!,
            preferredBodyType: dataManager.preferredBodyType!,
            preferredMbti: dataManager.preferredMbti!
        )
        print(signUpRequest)
        print("프로필사진: \(dataManager.profilePhotos)")
        NetworkService.shared.signUpService.signUp(bodyDTO: signUpRequest) { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                print("회원가입 성공")
            default:
                print("회원가입 에러")
            }
        }
        let tabVC = TabBarController()
        self.changeRootViewController(rootViewController: tabVC)
    }
    @objc func backButtonTapped() {
        // 뒤로 가기 로직을 구현
        dismiss(animated: true, completion: nil)
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        profileImage1.image = SignDataManager.shared.selectedImages[0]
        profileImage2.image = SignDataManager.shared.selectedImages[1]
        setupNavigationBar()
        // Create a dispatch group
        let dispatchGroup = DispatchGroup()
        
        // Enter the group before starting the first API request
        dispatchGroup.enter()
        
        // Start the first API request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.apiSimilarity(upload: SignDataManager.shared.selectedImages[0], real: SignDataManager.shared.selfieImage) { confidence in
                // Leave the group when the first API request is completed
                dispatchGroup.leave()
                self.confidence1 = confidence
            }
        }
        
        // Start the second API request after the first one is completed
        dispatchGroup.notify(queue: .main) {
            self.apiSimilarity(upload: SignDataManager.shared.selectedImages[1], real: SignDataManager.shared.selfieImage) {confidence in
                self.confidence2 = confidence
                self.addSubViews()
                self.configUI()
                var confidence = Int((self.confidence1 + self.confidence2) / 2)
                self.text2.text = "\(confidence)%에요!"
                if(confidence <= 75)
                {
                    self.explainText.text = "업로드한 사진과 실제 얼굴이 달라요\nAI 포토샵으로 유사도를 높일 수 있어요!"
                    self.startBtn.isHidden = true
                }
                else{
                    SignDataManager.shared.confidence = confidence
                    self.explainText.text = "지금 바로 원하는 이성을 찾아 보세요!"
                    self.selfieBtn.isHidden = true
                    self.aiBtn.isHidden = true
                }
                let fullText = self.text2.text ?? ""
                let attribtuedString = NSMutableAttributedString(string: fullText)
                let range = (fullText as NSString).range(of: "\(confidence)%")
                attribtuedString.addAttribute(.foregroundColor, value: UIColor.primary, range: range)
                self.text2.attributedText = attribtuedString
            }
        }
    }
    
    // MARK: Select RootViewController Function
    func changeRootViewController(rootViewController: UIViewController) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = BaseNavigationController(rootViewController: rootViewController)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func apiSimilarity(upload: UIImage, real: UIImage, completion: @escaping (Double) -> Void) {
        // Load images to compare
        let image1 = upload
        let image2 = real
        
        // Convert images to Data
        guard let imageData1 = image1.jpegData(compressionQuality: 1.0),
              let imageData2 = image2.jpegData(compressionQuality: 1.0) else {
            fatalError("Failed to convert images to data")
        }
        
        let url = "https://api-us.faceplusplus.com/facepp/v3/compare"
        let parameters: Parameters = [
            "api_key": "WC0CaE1oGhbR06_-SePXVM-iKQq0BCkT",
            "api_secret": "48cmzpAX4bUENmwbvKbBB_dNU4d-MdqV"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            // Add images to multipart form data
            multipartFormData.append(imageData1, withName: "image_file1", fileName: "uploadSelfie.jpeg", mimeType: "image/jpeg")
            multipartFormData.append(imageData2, withName: "image_file2", fileName: "realSelfie.jpeg", mimeType: "image/jpeg")
            
            // Add other parameters to multipart form data
            for (key, value) in parameters {
                if let data = String(describing: value).data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: url)
        .validate(statusCode: 200..<500)
        .responseJSON() { response in
            print(response)
        }
        .responseDecodable(of: FaceComparisonResult.self) { response in
            switch response.result {
                // [CASE] API 통신에 성공한 경우
            case .success(let value):
                print("성공하였습니다 :: \(value)")
                completion(value.confidence!)
                
                // [CASE] API 통신에 실패한 경우
            case .failure(let error):
                print("실패하였습니다 :: \(error)" )
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - UI Layout
    func configUI() {
        selfieImage.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaHeight).offset(20)
            make.right.equalTo(view.snp.centerX).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.height.equalTo(314)
            
        }
        
        profileImage1.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaHeight).offset(20)
            make.left.equalTo(selfieImage.snp.right).offset(10)
            make.right.equalTo(view.snp.right).offset(-20)
            make.height.equalTo(152)
            
        }
        profileImage2.snp.makeConstraints{ make in
            make.top.equalTo(profileImage1.snp.bottom).offset(10)
            make.left.equalTo(selfieImage.snp.right).offset(10)
            make.right.equalTo(view.snp.right).offset(-20)
            make.height.equalTo(152)
            
        }
        text1.snp.makeConstraints{ make in
            make.top.equalTo(selfieImage.snp.bottom).offset(69)
            make.centerX.equalToSuperview()
        }
        text2.snp.makeConstraints{ make in
            make.top.equalTo(text1.snp.bottom).offset(5.75)
            make.centerX.equalToSuperview()
            
        }
        explainText.snp.makeConstraints{ make in
            make.top.equalTo(text2.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            
        }
        selfieBtn.snp.makeConstraints{make in
            make.bottom.equalTo(view.snp.bottom).offset(-55)
            make.centerX.equalToSuperview()
            make.width.equalTo(353)
            make.height.equalTo(56)
        }
        //유사도 높으면 바로 시작
        startBtn.snp.makeConstraints{make in
            make.bottom.equalTo(view.snp.bottom).offset(-55)
            make.centerX.equalToSuperview()
            make.width.equalTo(353)
            make.height.equalTo(56)
        }

        
    }
    
    func addSubViews() {
        view.addSubview(selfieImage)
        view.addSubview(profileImage1)
        view.addSubview(profileImage2)
        view.addSubview(text1)
        view.addSubview(text2)
        view.addSubview(explainText)
        view.addSubview(selfieBtn)
        //유사도 높으면 시작 버튼
        view.addSubview(startBtn)
    }
}

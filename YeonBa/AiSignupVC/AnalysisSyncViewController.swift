import UIKit
import SnapKit
import Then

class AnalysisSyncViewController: UIViewController {
    
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
    
    let uploadText = UILabel().then{
        $0.text = "업로드 사진"
        $0.font = UIFont.pretendardSemiBold(size: 16)
        $0.textColor = UIColor.customgray4
    }
    let progressIcon = UIImageView().then{
        $0.image = UIImage(named: "ProgressIcon")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    let selfieImage = UIImageView().then{
        $0.image = SignDataManager.shared.selfieImage
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    let selfieText = UILabel().then{
        $0.text = "셀카"
        $0.font = UIFont.pretendardSemiBold(size: 16)
        $0.textColor = UIColor.customgray4
    }
    
    let selfieBtn = UIButton().then {
        $0.setTitle("셀카 다시찍기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.4
        $0.backgroundColor = UIColor.white
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(cameraBtnTapped), for: .touchUpInside)
    }
    
    let startBtn = ActualGradientButton().then {
        $0.setTitle("유사도 분석하러 가기", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(resultBtnTapped), for: .touchUpInside)
    }
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "사진 앨범"
    }
    //MARK: - Actions
    @objc func resultBtnTapped() {
        let AnaysisSyncResultVC = AnalysisSyncResultViewController()
        navigationController?.pushViewController(AnaysisSyncResultVC, animated: true)
    }
    @objc func cameraBtnTapped() {
        let guideVC = GuideViewController()
        navigationController?.pushViewController(guideVC, animated: true)
    }
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        addSubViews()
        configUI()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - UI Layout
    func configUI() {
        profileImage1.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.snp.centerX).offset(-4)
            make.width.equalTo(124)
            make.height.equalTo(152)
            
        }
        profileImage2.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view.snp.centerX).offset(4)
            make.width.equalTo(124)
            make.height.equalTo(152)
            
        }
        uploadText.snp.makeConstraints{ make in
            make.top.equalTo(profileImage1.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        progressIcon.snp.makeConstraints{make in
            make.top.equalTo(uploadText.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.width.equalTo(12)
            make.height.equalTo(42)
        }
        selfieImage.snp.makeConstraints{ make in
            make.top.equalTo(progressIcon.snp.bottom).offset(21)
            make.centerX.equalToSuperview()
            make.width.equalTo(188)
            make.height.equalTo(230)
            
        }
        selfieText.snp.makeConstraints{ make in
            make.top.equalTo(selfieImage.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            
        }
        selfieBtn.snp.makeConstraints{make in
            make.top.equalTo(selfieText.snp.bottom).offset(37)
            make.centerX.equalToSuperview()
            make.width.equalTo(353)
            make.height.equalTo(56)
        }
        startBtn.snp.makeConstraints{make in
            make.top.equalTo(selfieBtn.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(353)
            make.height.equalTo(56)
        }

        
    }
    
    func addSubViews() {
        view.addSubview(profileImage1)
        view.addSubview(profileImage2)
        view.addSubview(uploadText)
        view.addSubview(progressIcon)
        view.addSubview(selfieImage)
        view.addSubview(selfieText)
        view.addSubview(selfieBtn)
        view.addSubview(startBtn)
    }
}

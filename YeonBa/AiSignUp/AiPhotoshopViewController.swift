
import UIKit
import SnapKit
import Then

class AiPhotoshopViewController: UIViewController {
    
    // MARK: - UI Components
    let titleLabel = UILabel().then{
        $0.text = "AI 포토샵"
        $0.font = UIFont.pretendardMedium(size: 18)
    }
    let backButton = UIButton(type: .system).then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .light)
        let image = UIImage(named: "BackButton")
        $0.setImage(image, for: .normal)
        $0.tintColor = UIColor.black
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    let before = UILabel().then{
        $0.text = "Before"
        $0.font = UIFont.pretendardSemiBold(size: 16)
        $0.textColor = .gray
    }
    let after = UILabel().then{
        $0.text = "After"
        $0.font = UIFont.pretendardSemiBold(size: 16)
        $0.textColor = .primary
    }
    
    let profileImage1 = UIImageView().then{
        $0.image = UIImage(named: "GuideGoodImage1")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    let profileImage2 = UIImageView().then{
        $0.image = UIImage(named: "GuideGoodImage1")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    let text1 = UILabel().then{
        $0.text = "AI 포토샵으로 연방님의\n매력도를 올렸어요!"
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont.pretendardExtraBold(size: 32)
    }
    let explainText = UILabel().then{
        $0.text = "사진을 저장하여 프로필에 올려 보세요."
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textColor = UIColor.gray
    }
    
    let saveBtn = UIButton().then {
        $0.setTitle("사진 저장하기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.4
        $0.backgroundColor = UIColor.white
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(saveBtnTapped), for: .touchUpInside)
    }
    let uploadBtn = ActualGradientButton().then {
        $0.setTitle("재업로드 하기", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(uploadBtnTapped), for: .touchUpInside)
    }
    
    //MARK: - Actions
    @objc func didTapButton() {
        print("didTapButton tapped")
    }
    @objc func saveBtnTapped() {
        print("saveBtnTapped")
    }
    @objc func uploadBtnTapped() {
        let guideVC = GuideViewController()
        navigationController?.pushViewController(guideVC, animated: true)
    }
    @objc func backButtonTapped() {
        // 뒤로 가기 로직을 구현
        dismiss(animated: true, completion: nil)
    }
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        configUI()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    // MARK: - UI Layout
    func configUI() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(21)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.centerX.equalToSuperview()
        }
        
        
        profileImage1.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(136)
            make.right.equalTo(view.snp.centerX).offset(-5)
            make.width.equalTo(172)
            make.height.equalTo(244)
            
        }
        profileImage2.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(136)
            make.left.equalTo(view.snp.centerX).offset(5)
            make.width.equalTo(172)
            make.height.equalTo(244)
            
        }
        before.snp.makeConstraints{make in
            make.bottom.equalTo(profileImage1.snp.top).offset(-10)
            make.centerX.equalTo(profileImage1.snp.centerX)
        }
        after.snp.makeConstraints{ make in
            make.bottom.equalTo(profileImage2.snp.top).offset(-10)
            make.centerX.equalTo(profileImage2.snp.centerX)
        }
        text1.snp.makeConstraints{ make in
            make.top.equalTo(profileImage1.snp.bottom).offset(83)
            make.centerX.equalToSuperview()
        }
        explainText.snp.makeConstraints{ make in
            make.top.equalTo(text1.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        saveBtn.snp.makeConstraints{make in
            make.bottom.equalTo(view.snp.bottom).offset(-55)
            make.right.equalTo(view.snp.centerX).offset(-2.5)
            make.width.equalTo(174)
            make.height.equalTo(56)
        }
        uploadBtn.snp.makeConstraints{make in
            make.bottom.equalTo(view.snp.bottom).offset(-55)
            make.left.equalTo(view.snp.centerX).offset(2.5)
            make.width.equalTo(174)
            make.height.equalTo(56)
        }
        
    }
    
    func addSubViews() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(profileImage1)
        view.addSubview(profileImage2)
        view.addSubview(before)
        view.addSubview(after)
        view.addSubview(text1)
        view.addSubview(explainText)
        view.addSubview(saveBtn)
        view.addSubview(uploadBtn)
    }
}

import UIKit
import SnapKit
import Then

class FindIdResultViewController: UIViewController {
    
    // MARK: - UI Components
    let titleLabel = UILabel().then{
        $0.text = "아이디 찾기"
        $0.font = UIFont.pretendardMedium(size: 18)
    }
    let backButton = UIButton(type: .system).then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .light)
        let image = UIImage(named: "BackButton")
        $0.setImage(image, for: .normal)
        $0.tintColor = UIColor.black
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    let idLabel = UILabel().then {
        $0.text = "이유즨 님의 아이디는\n109203@naver.com 입니다"
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 20)
    }
    
    let loginBtn = ActualGradientButton().then {
        $0.setTitle("로그인 하기", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
    }
    //MARK: - Actions
    @objc func loginBtnTapped() {
        print("loginBtnTapped")
    }
    
    @objc func backButtonTapped() {
        // 뒤로 가기 로직을 구현
        dismiss(animated: true, completion: nil)
    }
        
        
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //특정 문자만 색상 변경, 퍼센트 부분 색상 변경
        let fullText = idLabel.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "109203@naver.com")
        attribtuedString.addAttribute(.foregroundColor, value: UIColor.primary, range: range)
        idLabel.attributedText = attribtuedString
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
        
        idLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        loginBtn.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-55)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(56)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(idLabel)
        view.addSubview(loginBtn)
    }
}

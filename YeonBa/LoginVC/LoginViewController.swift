
import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {
    
    // MARK: - UI Components
    let idLabel = UILabel().then{
        $0.text = "아이디"
        $0.font = UIFont.pretendardSemiBold(size: 16)
        $0.textColor = .black
    }
    let idTextField = UITextField().then {
        $0.placeholder = "아이디 입력"
        $0.borderStyle = .none
        $0.backgroundColor = .gray2
        $0.textColor = .customgray4
        $0.font = UIFont.pretendardRegular(size: 13)
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        $0.textAlignment = .left
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.leftViewMode = .always
    }
    let pwLabel = UILabel().then{
        $0.text = "비밀번호"
        $0.font = UIFont.pretendardSemiBold(size: 16)
        $0.textColor = .black
    }
    let pwTextField = UITextField().then {
        $0.placeholder = "비밀번호 입력"
        $0.borderStyle = .none
        $0.backgroundColor = .gray2
        $0.textColor = .customgray4
        $0.font = UIFont.pretendardRegular(size: 13)
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        $0.textAlignment = .left
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.leftViewMode = .always
    }
    
    let appIcon = UIImageView().then{
        $0.image = UIImage(named: "LoginAppIcon")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    let divider = UIImageView().then{
        $0.image = UIImage(named: "LoginDivider")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    let findIdBtn = UIButton().then {
        $0.setTitle("아이디 찾기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardMedium(size: 16)
        $0.addTarget(self, action: #selector(findIdBtnTapped), for: .touchUpInside)
    }
    let findPwBtn = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardMedium(size: 16)
        $0.addTarget(self, action: #selector(findPwBtnTapped), for: .touchUpInside)
    }
    
    let loginBtn = ActualGradientButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(logInBtnTapped), for: .touchUpInside)
    }
    //MARK: - Actions
    @objc func findIdBtnTapped() {
        let findIdVC = FindIdViewController()
        navigationController?.pushViewController(findIdVC, animated: true)
    }
    @objc func findPwBtnTapped() {
        let findpwVC = FindPwViewController()
        navigationController?.pushViewController(findpwVC, animated: true)
    }
    @objc func logInBtnTapped() {
        
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
        appIcon.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(108)
            make.width.equalTo(114)
            make.height.equalTo(118)
        }

        idLabel.snp.makeConstraints{make in
            make.top.equalTo(appIcon.snp.bottom).offset(64)
            make.leading.equalToSuperview().offset(20)
        }
        idTextField.snp.makeConstraints{make in
            make.top.equalTo(idLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
            
        }
        pwLabel.snp.makeConstraints{ make in
            make.top.equalTo(idTextField.snp.bottom).offset(37)
            make.leading.equalToSuperview().offset(20)
        }
        pwTextField.snp.makeConstraints{make in
            make.top.equalTo(pwLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        divider.snp.makeConstraints{make in
            make.top.equalTo(pwTextField.snp.bottom).offset(37)
            make.centerX.equalToSuperview()
        }
        findIdBtn.snp.makeConstraints{make in
            make.right.equalTo(view.snp.centerX).offset(-28)
            make.top.equalTo(pwTextField.snp.bottom).offset(37)
        }
        findPwBtn.snp.makeConstraints{make in
            make.left.equalTo(view.snp.centerX).offset(28)
            make.top.equalTo(pwTextField.snp.bottom).offset(37)
        }
        loginBtn.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-55)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(56)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    func addSubViews() {
        view.addSubview(appIcon)
        view.addSubview(idLabel)
        view.addSubview(idTextField)
        view.addSubview(pwLabel)
        view.addSubview(pwTextField)
        view.addSubview(divider)
        view.addSubview(findIdBtn)
        view.addSubview(findPwBtn)
        view.addSubview(loginBtn)
    }
}

import UIKit
import SnapKit
import Then

class FindPwResultViewController: UIViewController {
    // MARK: - UI Components
    let titleLabel = UILabel().then{
        $0.text = "비밀번호 변경"
        $0.font = UIFont.pretendardMedium(size: 18)
    }
    let backButton = UIButton(type: .system).then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .light)
        let image = UIImage(named: "BackButton")
        $0.setImage(image, for: .normal)
        $0.tintColor = UIColor.black
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    let headerLabel = UILabel().then {
        $0.text = "등록된 이메일로 찾기"
        $0.textColor = .black
        $0.font = UIFont.pretendardBold(size: 26)
    }
    let contentLabel = UILabel().then {
        $0.text = "가입 당시 입력한 이메일을 통해 인증 후\n새 비밀번호를 등록해주세요."
        $0.numberOfLines = 0
        $0.textColor = .customgray4
        $0.font = UIFont.pretendardMedium(size: 16)
    }
    let pwLabel = UILabel().then {
        $0.text = "새 비밀번호"
        $0.font = UIFont.pretendardSemiBold(size: 20)
        $0.textColor = .black
    }
    let pwTextField = UITextField().then{
        $0.placeholder = "변경할 비밀번호를 입력해 주세요."
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.borderStyle = .none
        $0.backgroundColor = .gray2
        $0.textColor = .customgray4
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        $0.textAlignment = .left
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.leftViewMode = .always
    }
    let hintLabel = UILabel().then {
        $0.text = "비밀번호는 영문 대소문자, 숫자, 특수문자(-!@3)를 포함하여\n8~20자로 설정해 주세요."
        $0.numberOfLines = 0
        $0.font = UIFont.pretendardRegular(size: 13)
        $0.textColor = .customgray4
    }
    let confirmLabel = UILabel().then {
        $0.text = "새 비밀번호 확인"
        $0.font = UIFont.pretendardSemiBold(size: 20)
        $0.textColor = .black
    }
    let emailConfirmTextField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "비밀번호를 한번 더 입력해 주세요."
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.backgroundColor = .gray2
        $0.textColor = .customgray4
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        $0.textAlignment = .left
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.leftViewMode = .always
    
    }
    let findPwBtn = ActualGradientButton().then {
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(changeBtnTapped), for: .touchUpInside)
    }
    //MARK: - Actions
    @objc func changeBtnTapped() {
        print("changeBtnTapped tapped")
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
        
        headerLabel.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
        }
        
        contentLabel.snp.makeConstraints{make in
            make.top.equalTo(headerLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
        }
        pwLabel.snp.makeConstraints{make in
            make.top.equalTo(contentLabel.snp.bottom).offset(61)
            make.leading.equalToSuperview().offset(20)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(pwLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        hintLabel.snp.makeConstraints{make in
            make.top.equalTo(pwTextField.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(20)
        }
        confirmLabel.snp.makeConstraints{make in
            make.top.equalTo(hintLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(20)
        }
        emailConfirmTextField.snp.makeConstraints{make in
            make.top.equalTo(confirmLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        findPwBtn.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-55)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(56)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(headerLabel)
        view.addSubview(contentLabel)
        view.addSubview(pwLabel)
        view.addSubview(pwTextField)
        view.addSubview(hintLabel)
        view.addSubview(confirmLabel)
        view.addSubview(emailConfirmTextField)
        view.addSubview(findPwBtn)
    }
}

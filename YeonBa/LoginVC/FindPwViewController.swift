import UIKit
import SnapKit
import Then

class FindPwViewController: UIViewController {
    // MARK: - UI Components
    let titleLabel = UILabel().then{
        $0.text = "비밀번호 찾기"
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
    let emailLabel = UILabel().then {
        $0.text = "이메일"
        $0.font = UIFont.pretendardSemiBold(size: 20)
        $0.textColor = .black
    }
    let emailTextField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "이메일 입력"
        $0.keyboardType = .emailAddress
        $0.font = UIFont.pretendardSemiBold(size: 20)
    }
    let errorTextLabel = UILabel().then {
        $0.text = "올바르지 않은 이메일 형식입니다."
        $0.font = UIFont.pretendardSemiBold(size: 20)
        $0.textColor = .red
    }
    let sendButton = UIButton().then{
        $0.setTitle("전송", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 6
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1.6
        $0.backgroundColor = UIColor.white
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(sendBtnTapped), for: .touchUpInside)
    }
    let confirmLabel = UILabel().then {
        $0.text = "이메일 인증"
        $0.font = UIFont.pretendardSemiBold(size: 16)
        $0.textColor = .black
    }
    let emailConfirmTextField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "이메일에 전송된 번호를 입력해 주세요."
        $0.keyboardType = .numberPad
        $0.font = UIFont.pretendardSemiBold(size: 20)
        $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40)) // sendButton의 width와 동일하게 설정
        $0.rightViewMode = .always
    }
    let deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "DeleteEmail"), for: .normal) // 전송 아이콘 이미지 설정
        $0.contentMode = .scaleAspectFit
        }
    let findPwBtn = ActualGradientButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(finPwBtnTapped), for: .touchUpInside)
    }
    //MARK: - Actions
    @objc func finPwBtnTapped() {
        let findpwResultVC = FindPwResultViewController()
        navigationController?.pushViewController(findpwResultVC, animated: true)
    }
    @objc func sendBtnTapped() {
        print("didTapButton tapped")
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailTextField.addBottomBorder(withColor: .black, andHeight: 1.0)
        emailConfirmTextField.addBottomBorder(withColor: .black, andHeight: 1.0)
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
        emailLabel.snp.makeConstraints{make in
            make.top.equalTo(contentLabel.snp.bottom).offset(58)
            make.leading.equalToSuperview().offset(20)
        }
        
        sendButton.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(46)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(19)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(sendButton.snp.leading).offset(-8)
            make.height.equalTo(40)
        }
        errorTextLabel.snp.makeConstraints{make in
            make.top.equalTo(emailTextField.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(20)
        }
        confirmLabel.snp.makeConstraints{make in
            make.top.equalTo(errorTextLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(20)
        }
        emailConfirmTextField.snp.makeConstraints{make in
            make.top.equalTo(confirmLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        deleteButton.snp.makeConstraints{make in
            make.centerY.equalTo(emailConfirmTextField.snp.centerY)
            make.trailing.equalToSuperview().offset(-28)
            make.width.height.equalTo(22)
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
        view.addSubview(sendButton)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(errorTextLabel)
        view.addSubview(confirmLabel)
        view.addSubview(emailConfirmTextField)
        view.addSubview(deleteButton)
        view.addSubview(findPwBtn)
    }
}

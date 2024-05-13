import UIKit
import SnapKit
import Then

class FindIdViewController: UIViewController {
    
    // Timer
    var timer: Timer?
    var remainingSeconds = 180
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
    
    let headerLabel = UILabel().then {
        $0.text = "등록된 전화번호로 찾기"
        $0.textColor = .black
        $0.font = UIFont.pretendardBold(size: 26)
    }
    let contentLabel = UILabel().then {
        $0.text = "가입 당시 입력한 전화번호를 입력해 주세요."
        $0.textColor = .customgray4
        $0.font = UIFont.pretendardMedium(size: 16)
    }
    let phoneNumberTextField = UITextField().then{
        // 전화번호 입력 필드
        $0.borderStyle = .none
        $0.placeholder = "전화번호 입력"
        $0.keyboardType = .numberPad
        $0.font = UIFont.pretendardSemiBold(size: 20)
                
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
        $0.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    let timerLabel = UILabel().then{
        // 타이머 라벨
        $0.text = "3:00"
        $0.textAlignment = .center
        $0.textColor = .customgray4
        $0.font = UIFont.pretendardSemiBold(size: 18)
    }
    let verificationTextFields = [UITextField(), UITextField(), UITextField(), UITextField(), UITextField(), UITextField()]
    let confirmButton = UIButton().then{
        // 인증 버튼
        $0.setTitle("인증", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 6
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1.6
        $0.backgroundColor = UIColor.white
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    
    let findIdBtn = ActualGradientButton().then {
        $0.setTitle("아이디 찾기", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(findIdBtnTapped), for: .touchUpInside)
    }
    //MARK: - Actions
    @objc func backButtonTapped() {
        // 뒤로 가기 로직을 구현
        dismiss(animated: true, completion: nil)
    }
    @objc private func sendButtonTapped() {
        startTimer()
    }
    @objc func findIdBtnTapped() {
        let findIdResultVC = FindIdResultViewController()
        navigationController?.pushViewController(findIdResultVC, animated: true)
    }
    @objc func logInBtnTapped() {
        
    }
    private func startTimer() {
        remainingSeconds = 180
        timerLabel.text = "3:00"
        
        timer?.invalidate() // 기존 타이머가 있다면 해제
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc private func updateTimer() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1
            let minutes = remainingSeconds / 60
            let seconds = remainingSeconds % 60
            timerLabel.text = String(format: "%d:%02d", minutes, seconds)
        } else {
            timer?.invalidate()
            timerLabel.text = "시간 초과"
        }
    }
        
    @objc private func confirmButtonTapped() {
        // 인증 로직 구현 필요
    }
        
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // 인증번호 입력 필드들
        verificationTextFields.forEach { textField in
            textField.textAlignment = .center
            textField.borderStyle = .none
            textField.keyboardType = .numberPad
            textField.font = UIFont.pretendardSemiBold(size: 30)
        }
        addSubViews()
        configUI()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        phoneNumberTextField.addBottomBorder(withColor: .black, andHeight: 1.0)
        verificationTextFields.forEach {
            $0.addBottomBorder(withColor: .black, andHeight: 1.0)
        }
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
        
        sendButton.snp.makeConstraints { make in
            make.centerY.equalTo(phoneNumberTextField.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(46)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(64)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(sendButton.snp.leading).offset(-8)
            make.height.equalTo(40)
        }
        
        var previousTextField: UITextField?
        for textField in verificationTextFields {
            textField.snp.makeConstraints { make in
                make.top.equalTo(phoneNumberTextField.snp.bottom).offset(51)
                make.width.height.equalTo(40)
                
                if let previousTextField = previousTextField {
                    make.leading.equalTo(previousTextField.snp.trailing).offset(7)
                } else {
                    make.leading.equalTo(view).offset(20)
                }
            }
            previousTextField = textField
        }
        confirmButton.snp.makeConstraints { make in
            make.centerY.equalTo(verificationTextFields.last!.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(46)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(verificationTextFields.first!.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(20)
        }

        findIdBtn.snp.makeConstraints{make in
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
        view.addSubview(phoneNumberTextField)
        view.addSubview(confirmButton)
        view.addSubview(sendButton)
        view.addSubview(timerLabel)
        verificationTextFields.forEach(view.addSubview)
        view.addSubview(findIdBtn)
    }
}
extension UITextField {
    func addBottomBorder(withColor color: UIColor, andHeight height: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.frame.size.width, height: height)
        self.layer.addSublayer(border)
    }
}

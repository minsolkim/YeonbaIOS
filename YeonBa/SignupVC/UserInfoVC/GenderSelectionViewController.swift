import UIKit
import SnapKit
import Then

class GenderSelectionViewController: UIViewController {
    
    var selectedGenderButton: UIButton?
    
    let numberLabel = UILabel().then {
        $0.text = "1/6"
        $0.textColor = .red
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 24)
        $0.numberOfLines = 0
    }
    
    let instructionLabel = UILabel().then {
        $0.text = "성별을 선택해 주세요."
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 24)
        $0.numberOfLines = 0
    }
    
    let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    
    let nextButton = ActualGradientButton().then {
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 25
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupButtons()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        navigationItem.title = "나의 정보"
        
        view.addSubviews(numberLabel,instructionLabel,verticalStackView,nextButton)
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(70)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-55)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    private func setupButtons() {
        let genderOptions = ["남", "여"]
        
        for gender in genderOptions {
            let button = UIButton().then {
                $0.setTitle(gender, for: .normal)
                $0.setTitleColor(.black, for: .normal)
                $0.backgroundColor = .white
                $0.layer.cornerRadius = 10
                $0.layer.borderWidth = 1.0
                $0.layer.borderColor = UIColor.lightGray.cgColor
                $0.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
            }
            verticalStackView.addArrangedSubview(button)
            
            button.snp.makeConstraints { make in
                make.height.equalTo(51)
            }
        }
    }
    
    private func setupKeyboardDismissal() {
        // 키보드가 활성화된 상태에서 화면을 터치했을 때 키보드가 사라지도록 설정합니다.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        // 키보드를 숨깁니다.
        view.endEditing(true)
    }
    
    @objc private func genderButtonTapped(_ sender: UIButton) {
        selectedGenderButton?.backgroundColor = .white
        selectedGenderButton?.setTitleColor(.black, for: .normal)
        selectedGenderButton?.layer.borderColor = UIColor.lightGray.cgColor
        
        sender.backgroundColor = .white
        sender.setTitleColor(.red, for: .normal)
        sender.layer.borderColor = UIColor.red.cgColor
        
        selectedGenderButton = sender
    }
    
    @objc private func nextButtonTapped() {
        guard selectedGenderButton != nil else {
            let alert = UIAlertController(title: "성별 선택", message: "계속하려면 성별을 선택해 주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        if let gender = selectedGenderButton?.titleLabel?.text {
            SignDataManager.shared.gender = gender
        }
        let nextVC = BodyInfoViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}





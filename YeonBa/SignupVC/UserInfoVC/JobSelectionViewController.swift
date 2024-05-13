import UIKit
import SnapKit
import Then

class JobSelectionViewController: UIViewController {
    
    var selectedJobButton: UIButton?
    
    
    let numberLabel = UILabel().then {
        $0.text = "3/6"
        $0.textColor = .red
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 24)
        $0.numberOfLines = 0
    }
    
    let instructionLabel = UILabel().then {
        $0.text = "직업을 선택해 주세요."
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 24)
        $0.numberOfLines = 0
    }
    
    let addinstructionLabel = UILabel().then {
        $0.text = "매칭을 위해 필수 단계입니다."
        $0.textColor = .gray
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 16)
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
        $0.backgroundColor = UIColor.red
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
        
        view.addSubview(numberLabel)
        view.addSubview(instructionLabel)
        view.addSubview(addinstructionLabel)
        view.addSubview(verticalStackView)
        view.addSubview(nextButton)
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().inset(20)
        }
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(20)
        }
        
        addinstructionLabel.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(addinstructionLabel.snp.top).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        
        
        // Set up constraints for the next button
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-55)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
    }
    
    private func setupButtons() {
        let jobTitles = ["학생", "직장인", "프리랜서", "취업준비생", "기타"]
        
        
        for jobTitle in jobTitles {
            let button = UIButton().then {
                $0.setTitle(jobTitle, for: .normal)
                $0.setTitleColor(.black, for: .normal)
                $0.backgroundColor = .white
                $0.layer.cornerRadius = 10
                $0.layer.borderWidth = 1.0
                $0.layer.borderColor = UIColor.lightGray.cgColor
                $0.addTarget(self, action: #selector(jobButtonTapped(_:)), for: .touchUpInside)
            }
            verticalStackView.addArrangedSubview(button)
            
            button.snp.makeConstraints { make in
                make.height.equalTo(51)
            }
        }
        
    }
    
    @objc private func jobButtonTapped(_ sender: UIButton) {// 이전에 선택된 버튼의 스타일을 초기화합니다.
        // 이전에 선택된 버튼의 스타일을 초기화합니다.
        selectedJobButton?.backgroundColor = .white
        selectedJobButton?.setTitleColor(.black, for: .normal)
        selectedJobButton?.layer.borderColor = UIColor.lightGray.cgColor
        
        // 새로 선택된 버튼의 스타일을 업데이트합니다.
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(.primary, for: .normal) // 선택된 상태의 텍스트 색상을 빨간색으로 설정
        sender.layer.borderColor = UIColor.red.cgColor // 선택된 상태의 테두리 색상을 빨간색으로 설정
        
        // 새로 선택된 버튼을 저장합니다.
        selectedJobButton = sender
        
        // 나머지 버튼들의 스타일을 초기화합니다.
        for case let button as UIButton in verticalStackView.arrangedSubviews {
            if button != sender {
                button.backgroundColor = .white
                button.setTitleColor(.black, for: .normal)
                button.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        
        // 선택된 직업을 처리합니다.
        guard let jobTitle = sender.titleLabel?.text else { return }
        print("Selected job: \(jobTitle)")
    }
    
    @objc private func nextButtonTapped() {
        guard selectedJobButton != nil else {
            // 경고 메시지 표시 또는 사용자에게 선택하라고 알림
            showAlertForJobSelection()
            return
        }
        SignDataManager.shared.job = selectedJobButton?.currentTitle
        print(selectedJobButton?.currentTitle ?? "nil")
        // 선택된 경우, LocalSelectViewController로 화면 전환
        let localSelectVC = LocalSelectViewController()
        navigationController?.pushViewController(localSelectVC, animated: true)
    }
    
    // 사용자가 직업을 선택하지 않았을 때 경고를 표시하는 메서드
    private func showAlertForJobSelection() {
        let alert = UIAlertController(title: "직업 선택", message: "계속하려면 직업을 선택해 주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

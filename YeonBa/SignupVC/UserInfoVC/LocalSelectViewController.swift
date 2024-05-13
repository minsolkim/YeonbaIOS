import UIKit
import SnapKit
import Then

class LocalSelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let locals = ["서울", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"]
    
    var selectedLocal: String? {
        didSet {
            // 선택된 지역을 버튼의 타이틀로 설정
            localPickerButton.setTitle(selectedLocal, for: .normal)
            // 피커 뷰를 숨기는 로직을 여기에 추가할 수 있습니다.
            localPicker.isHidden = true
        }
    }
    
    
    var localTitleLabel: UILabel!
    
    let localPicker = UIPickerView()
    
    let numberLabel = UILabel().then {
        $0.text = "4/6"
        $0.textColor = .red
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 24)
        $0.numberOfLines = 0
    }
    
    let instructionLabel = UILabel().then {
        $0.text = "지역정보를 입력해 주세요."
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 24)
        $0.numberOfLines = 0
    }
    
    let localPickerButton = UIButton().then {
        $0.setTitle("지역 선택", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white // 배경을 흰색으로 설정
        $0.layer.borderWidth = 1.0 // 테두리 두께 설정
        $0.layer.borderColor = UIColor.gray.cgColor // 테두리 색상을 회색으로 설정
        $0.layer.cornerRadius = 10 // 모서리를 약간 둥글게 설정
        $0.addTarget(self, action: #selector(showLocalPicker), for: .touchUpInside)
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
        localPicker.isHidden = true
        localPicker.delegate = self
        localPicker.dataSource = self
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        navigationItem.title = "나의 정보"
        
        view.addSubview(numberLabel)
        view.addSubview(instructionLabel)
        view.addSubview(localPickerButton)
        view.addSubview(localPicker)
        view.addSubview(nextButton)
        
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(70)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        localPickerButton.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        localPicker.snp.makeConstraints { make in
            make.top.equalTo(localPickerButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            // 피커 뷰의 높이 설정은 필요에 따라 조정할 수 있습니다.
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-55)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    @objc func nextButtonTapped() {
        if let selectedLocal = selectedLocal {
            print("선택된 지역: \(selectedLocal)")
            SignDataManager.shared.activityArea = selectedLocal
            let InterestsVC = InterestsViewController()
            navigationController?.pushViewController(InterestsVC, animated: true)
        } else {
            showAlertForIncompleteSelection()
        }
    }
    
    private func showAlertForIncompleteSelection() {
        let alert = UIAlertController(title: "선택 누락", message: "지역을 선택해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locals.count // 지역 배열의 크기를 반환합니다.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locals[row] // 해당 행의 지역 이름을 반환합니다.
    }
    
    
    @objc private func showLocalPicker() {
        // 피커 뷰를 표시합니다.
        localPicker.isHidden = false
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 사용자가 선택한 지역을 버튼에 설정하고 피커 뷰를 숨깁니다.
        localPickerButton.setTitle(locals[row], for: .normal)
        localPicker.isHidden = true
        selectedLocal = locals[row]
    }
    
}

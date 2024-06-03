import UIKit
import SnapKit
import Then

protocol LivingAreaViewControllerDelegate: AnyObject {
    func didSelectLivingArea(_ area: String)
}

class LivingAreaViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: LivingAreaViewControllerDelegate?
    
    let areaPickerView = UIPickerView()
    let areas = ["서울", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"]
    
    let areaLabel = UILabel().then {
        $0.text = "사는 지역"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 24)
    }
    
    let doneButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 15)
        $0.layer.cornerRadius = 20
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.masksToBounds = true
        $0.isEnabled = false
        
    }
    
    let cancelButton = ActualGradientButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 15)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPickerView()
        setupLayout()
        setupActions()
    }
    
    private func setupPickerView() {
        areaPickerView.delegate = self
        areaPickerView.dataSource = self
    }
    
    private func setupLayout() {
        view.addSubview(areaLabel)
        view.addSubview(areaPickerView)
        view.addSubview(doneButton)

        areaLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(20)
        }

        areaPickerView.snp.makeConstraints { make in
            make.top.equalTo(areaLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        let buttonStackView = UIStackView(arrangedSubviews: [doneButton, cancelButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        view.addSubview(buttonStackView)

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(areaPickerView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        
    
    }
    
    private func setupActions() {
        doneButton.addTarget(self, action: #selector(dismissAreaPicker), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelAreaPicker), for: .touchUpInside)  
    }

    @objc private func dismissAreaPicker() {
        let selectedRow = areaPickerView.selectedRow(inComponent: 0)
        let selectedArea = areas[selectedRow]
        delegate?.didSelectLivingArea(selectedArea)
        dismiss(animated: true, completion: nil)
    }

    @objc private func cancelAreaPicker() {
        dismiss(animated: true, completion: nil)
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return areas.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return areas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        doneButton.isEnabled = true
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.layer.borderColor = UIColor.black.cgColor
    }
}

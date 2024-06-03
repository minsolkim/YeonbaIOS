import UIKit
import SnapKit
import Then

protocol HeightEditViewControllerDelegate: AnyObject {
    func didSelectHeight(_ height: Int)
}
class HeightEditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: HeightEditViewControllerDelegate?
    
    let pickerView = UIPickerView()
    let heights: [Int] = (140...220).map { $0 }
    
    let heightLabel = UILabel().then {
        $0.text = "키"
        $0.textColor = .black
        $0.textAlignment = .left
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
        pickerView.delegate = self
        pickerView.dataSource = self
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(heightLabel)
        view.addSubview(pickerView)
        let buttonStackView = UIStackView(arrangedSubviews: [doneButton, cancelButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        view.addSubview(buttonStackView)

        heightLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(heightLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(pickerView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        doneButton.addTarget(self, action: #selector(dismissPicker), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelPicker), for: .touchUpInside)
    }
    
    @objc private func dismissPicker() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        if selectedRow != -1 {
            delegate?.didSelectHeight(heights[selectedRow])
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func cancelPicker() {
        dismiss(animated: true, completion: nil)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return heights.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(heights[row])cm"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        doneButton.isEnabled = true
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.layer.borderColor = UIColor.black.cgColor
    }
}

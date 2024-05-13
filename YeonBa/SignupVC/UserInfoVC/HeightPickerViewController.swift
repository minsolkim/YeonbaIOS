import UIKit
import SnapKit
import Then

protocol HeightPickerViewControllerDelegate: AnyObject {
    func didSelectHeight(_ height: Int)
}
class HeightPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: HeightPickerViewControllerDelegate?
    
    
    let pickerView = UIPickerView()
    
    // Define the range of heights to pick from, e.g., 140cm to 200cm
    let heights: [Int] = (140...200).map { $0 }
    
    let doneButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(dismissPicker), for: .touchUpInside)

    }
    
    let heightLabel = UILabel().then {
        $0.text = "키"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 24)
    }

    let promptLabel = UILabel().then {
        $0.text = "프로필에 키를 추가해보세요."
        $0.textColor = .gray
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 20)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        pickerView.delegate = self
        pickerView.dataSource = self
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(doneButton)
        view.addSubview(heightLabel)
        view.addSubview(promptLabel)
        view.addSubview(pickerView)
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        heightLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(51)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(24)
        }
        
        promptLabel.snp.makeConstraints { make in
            make.top.equalTo(heightLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(promptLabel.snp.bottom).offset(25)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
    }
    
 
    @objc private func dismissPicker() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        if selectedRow >= 0 { // 유효한 행이 선택된 경우
            let selectedHeight = heights[selectedRow]
            delegate?.didSelectHeight(selectedHeight)
        } else { // 선택된 행이 없는 경우
            // 적절한 처리를 합니다.
        }
        dismiss(animated: true, completion: nil)
    }


    

    // UIPickerView DataSource and Delegate methods
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
        let selectedHeight = heights[row] // 옵셔널이 아니므로 직접 사용
        delegate?.didSelectHeight(selectedHeight)
    }

}



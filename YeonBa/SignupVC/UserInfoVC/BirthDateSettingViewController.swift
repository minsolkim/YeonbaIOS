//
//  BirthDateSettingViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 2/29/24.
//
import UIKit
import SnapKit
import Then
import Alamofire
import SwiftKeychainWrapper

class BirthDateSettingViewController: UIViewController {
    
    let instructionLabel = UILabel().then {
        $0.text = "생년월일을 입력해 주세요."
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 24)
        $0.numberOfLines = 0
    }
    
    let instructionLabel2 = UILabel().then {
        $0.text = "매칭을 위해 필수단계입니다. 이후 변경이 불가합니다."
        $0.textColor = .darkGray
        $0.font = UIFont.pretendardSemiBold(size: 12)
        $0.numberOfLines = 1
        $0.textAlignment = .left
    }
    
    let yearTextField = UITextField().then {
        $0.placeholder = "YYYY"
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 8
        $0.textAlignment = .center
        $0.keyboardType = .numberPad
    }
    
    let monthTextField = UITextField().then {
        $0.placeholder = "MM"
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 8
        $0.textAlignment = .center
        $0.keyboardType = .numberPad
    }
    
    let dayTextField = UITextField().then {
        $0.placeholder = "DD"
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 8
        $0.textAlignment = .center
        $0.keyboardType = .numberPad
    }
    
    let nextButton = ActualGradientButton().then {
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 25
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    // 생년월일을 선택하기 위한 피커뷰
    lazy var yearPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    lazy var monthPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    lazy var dayPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupKeyboardDismissal()
        setupViews()
        yearTextField.inputView = yearPickerView
        monthTextField.inputView = monthPickerView
        dayTextField.inputView = dayPickerView
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "회원가입"
    }
    
    private func setupViews() {
        view.addSubviews(instructionLabel,instructionLabel2,yearTextField,monthTextField,dayTextField,nextButton)
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        instructionLabel2.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        yearTextField.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel2.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(70)
            make.height.equalTo(40)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.top)
            make.left.equalTo(yearTextField.snp.right).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(40)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.top)
            make.left.equalTo(monthTextField.snp.right).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(40)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-55)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
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
    @objc func nextButtonTapped() {
        guard let year = yearTextField.text,let month = monthTextField.text,let day = dayTextField.text else {
            return
        }
        
        let birthDate = "\(year)-\(month)-\(day)"
        SignDataManager.shared.birthDate = birthDate
        
        let nextVC = NicknameSettingViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension BirthDateSettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == yearPickerView {
            let maxYear = 2005
            let minYear = 1984
            return maxYear - minYear + 1
        } else if pickerView == monthPickerView {
            return 12 // 월은 1부터 12까지
        } else {
            return 31 // 일은 1부터 31까지
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == yearPickerView {
            let maxYear = 2005
            let minYear = 1984
            let selectedYear = maxYear - row
            return "\(selectedYear)"
        } else if pickerView == monthPickerView {
            // 한 자리 수일 때 앞에 0을 붙여줌
            return String(format: "%02d", row + 1)
        } else {
            // 한 자리 수일 때 앞에 0을 붙여줌
            return String(format: "%02d", row + 1)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == yearPickerView {
            let maxYear = 2005
            let minYear = 1984
            let selectedYear = maxYear - row
            yearTextField.text = "\(selectedYear)"
        } else if pickerView == monthPickerView {
            let formattedMonth = String(format: "%02d", row + 1)
            monthTextField.text = formattedMonth
        } else {
            let formattedDay = String(format: "%02d", row + 1)
            dayTextField.text = formattedDay
        }
    }
}

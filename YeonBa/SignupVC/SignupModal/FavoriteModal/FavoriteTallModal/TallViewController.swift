//
//  TallViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 5/10/24.
//

import UIKit
import SnapKit

protocol TallViewControllerDelegate: AnyObject {
    func favoriteTallSelected(_ mode: String)
}

class TallViewController: UIViewController {
    private var selectedMode: String?
    weak var delegate: TallViewControllerDelegate?
    
    private let titleLabel = UILabel().then {
        $0.text = "선호하는 키"
        $0.textColor = UIColor.black
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 26)
    }
    
    private let slider: JKSlider = {
        let slider = JKSlider()
        slider.minValue = 140
        slider.maxValue = 220
        slider.lower = 140
        slider.upper = 220
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        return slider
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.text = "140~220cm"
        label.font = .pretendardSemiBold(size: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    
    private let finishButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 15)
        $0.setTitleColor(UIColor.customgray3, for: .normal)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.backgroundColor = UIColor.gray2?.cgColor
        $0.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
    }
    
    private let nextButton = ActualGradientButton().then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 15)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @objc private func finishButtonTapped() {
        //label.text = "\(Int(self.slider.lower)) ~ \(Int(self.slider.upper))"
        changeValue()
        self.dismiss(animated: true)
    }
    
    @objc private func nextButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func changeValue() {
        self.label.text = "\(Int(self.slider.lower)) ~ \(Int(self.slider.upper))"
        self.selectedMode = label.text
        delegate?.favoriteTallSelected(label.text ?? "140~220cm")
    }
}
extension TallViewController {
    private func setupViews() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        addSubviews()
        configUI()
    }
    func addSubviews() {
        view.addSubviews(titleLabel,slider,label,horizontalStackView)
        horizontalStackView.addArrangedSubview(finishButton)
        horizontalStackView.addArrangedSubview(nextButton)
    }
    func configUI() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(51)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        self.slider.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(300)
            $0.center.equalToSuperview()
        }
        self.label.snp.makeConstraints {
            $0.bottom.equalTo(slider.snp.top).offset(-30)
            $0.centerX.equalToSuperview()
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
       
    }
}

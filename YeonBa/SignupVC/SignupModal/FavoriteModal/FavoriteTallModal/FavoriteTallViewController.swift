//
//  FavoriteTallViewController.swift
//  YeonBa
//
//  Created by jin on 4/15/24.
//

import UIKit
import SnapKit
import Then

protocol FavoriteTallViewControllerDelegate: AnyObject {
    func tallSelected(_ mode: String)
}

final class FavoriteTallViewController: UIViewController{
    func sliderValueChanged(lowerValue: Double, upperValue: Double) {
        tallRangeLabel.text = "\(Int(lowerValue)) ~ \(Int(upperValue))"
    }
    private var selectedMode: String?
    weak var delegate: FavoriteTallViewControllerDelegate?
    
    private let customTransitioningDelegate = FavoriteTallDelegate()
    private let titleLabel = UILabel().then {
        $0.text = "선호하는 키"
        $0.textColor = UIColor.black
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 26)
    }
    private let tallSlider = JKSlider().then {
        $0.minValue = 140
        $0.maxValue = 220
        $0.lower = 140
        $0.upper = 220
    }
    private let tallRangeLabel = UILabel().then {
        $0.text = "140~175cm"
        $0.textColor = UIColor.primary
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 16)
    }
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
    }
    
    init(passMode: String) {
        super.init(nibName: nil, bundle: nil)
        setupModalStyle()
        selectedMode = passMode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupModalStyle() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .coverVertical
        transitioningDelegate = customTransitioningDelegate
    }
    
    private func setupInitialView() {
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
    
    @objc private func finishButtonTapped() {
        // Finish 버튼을 터치했을 때의 동작
        self.selectedMode = tallRangeLabel.text
        tallRangeLabel.text = "\(Int(self.tallSlider.lower)) ~ \(Int(self.tallSlider.upper))"
        delegate?.tallSelected(tallRangeLabel.text ?? "20~25세")
        self.dismiss(animated: true)
    }
}

// MARK: 나이 버튼 Setup Layout
extension FavoriteTallViewController {
    private func setupView() {
        setupInitialView()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubviews(titleLabel,tallRangeLabel,tallSlider,horizontalStackView)
        horizontalStackView.addArrangedSubview(finishButton)
        horizontalStackView.addArrangedSubview(nextButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(51)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        tallRangeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(41)
            $0.trailing.equalToSuperview().offset(-20)
        }
        tallSlider.snp.makeConstraints {
            $0.top.equalTo(tallRangeLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(21)
        }
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}

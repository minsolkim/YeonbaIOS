//
//  FavoriteAgeViewController.swift
//  YeonBa
//
//  Created by jin on 4/11/24.
//

import UIKit
import SnapKit
import Then

protocol FavoriteAgeViewControllerDelegate: AnyObject {
    func ageSelected(_ mode: String)
}

final class FavoriteAgeViewController: UIViewController,JKSliderDelegate {
    func sliderValueChanged(lowerValue: Double, upperValue: Double) {
        ageRangeLabel.text = "\(Int(lowerValue)) ~ \(Int(upperValue))"
    }
    
    private var selectedMode: String?
    weak var delegate: FavoriteAgeViewControllerDelegate?
    
    private let customTransitioningDelegate = FavoriteAgeDelegate()
    private let titleLabel = UILabel().then {
        $0.text = "선호하는 나이"
        $0.textColor = UIColor.black
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 26)
    }
    private let ageView = UIView().then {
        $0.backgroundColor = .green
        
    }
    private let ageSlider = JKSlider().then {
        $0.minValue = 20
        $0.maxValue = 40
        $0.lower = 20
        $0.upper = 40
    }
    private let ageRangeLabel = UILabel().then {
        $0.text = "20~40세"
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
        ageSlider.delegate = self
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
        self.selectedMode = ageRangeLabel.text
        ageRangeLabel.text = "\(Int(self.ageSlider.lower)) ~ \(Int(self.ageSlider.upper))"
        delegate?.ageSelected(ageRangeLabel.text ?? "20~25세")
        self.dismiss(animated: true)
    }

}

// MARK: 나이 버튼 Setup Layout
extension FavoriteAgeViewController {
    private func setupView() {
        setupInitialView()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubviews(ageView,titleLabel,horizontalStackView)
        horizontalStackView.addArrangedSubview(finishButton)
        horizontalStackView.addArrangedSubview(nextButton)
        ageView.addSubviews(ageRangeLabel,ageSlider)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(51)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        ageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(100)
        }
//        ageRangeLabel.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(41)
//            $0.trailing.equalToSuperview().offset(-20)
//        }
//        ageSlider.snp.makeConstraints {
//            $0.top.equalTo(ageRangeLabel.snp.bottom).offset(9)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.height.equalTo(21)
//        }
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}

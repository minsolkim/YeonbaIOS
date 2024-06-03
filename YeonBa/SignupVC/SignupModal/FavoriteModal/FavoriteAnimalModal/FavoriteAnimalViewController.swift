//
//  FavoriteAnimalViewController.swift
//  YeonBa
//
//  Created by jin on 4/10/24.
//
import UIKit
import SnapKit
import Then

protocol FavoriteAnimalViewControllerDelegate: AnyObject {
    func animalSelected(_ mode: AnimalMode)
}

final class FavoriteAnimalViewController: UIViewController {
    
    private var selectedMode: AnimalMode?
    weak var delegate: FavoriteAnimalViewControllerDelegate?
    private var bodyViewMode: SignWeightMode = .empty
    private var locationViewMode: SignLocationMode = .empty
    private let customTransitioningDelegate = FavoriteAnimalDelegate()
    private let titleLabel = UILabel().then {
        $0.text = "선호하는 동물 상"
        $0.textColor = UIColor.black
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 26)
    }
    private let horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    private let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    let horizontalStackView1 = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    let horizontalStackView2 = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    let horizontalStackView3 = UIStackView().then {
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
        $0.isEnabled = false
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
    
    init(passMode: AnimalMode) {
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
    
    private func dismissView() {
        self.dismiss(animated: true)
    }
    
    @objc private func animalButtonTapped(_ sender: UIButton) {
        guard let mode = AnimalMode(rawValue: sender.tag) else { return }
        self.selectedMode = mode
        // 선택한 동물 모드를 delegate를 통해 호출한 쪽에 전달
        // 선택된 버튼 스타일 변경
        updateButtonSelection()
    }
    
    @objc private func finishButtonTapped() {
        // Finish 버튼을 터치했을 때의 동작
        delegate?.animalSelected(self.selectedMode!)
        self.dismiss(animated: true)
        
    }
    
    @objc private func nextButtonTapped() {
        dismiss(animated: true) {
            let locationVC = FavoriteLocationViewController(passMode: self.locationViewMode)
            // 새로운 모달 창 표시
            self.present(locationVC, animated: true)
        }
    }
    
    private func updateButtonSelection() {
        // 모든 버튼의 선택 상태 초기화
        for case let horizontalStackView as UIStackView in verticalStackView.arrangedSubviews {
            for case let button as UIButton in horizontalStackView.arrangedSubviews {
                button.isSelected = false
                button.layer.borderColor = UIColor.customgray2?.cgColor
                button.setTitleColor(.customgray2, for: .normal)
            }
        }
        
        // 선택한 버튼만 선택 상태로 변경
        if let selectedMode = selectedMode,
           let button = findButton(for: selectedMode) {
            button.isSelected = true
            button.layer.borderColor = UIColor.primary?.cgColor
            button.setTitleColor(.primary, for: .normal) // 선택된 버튼의 텍스트 색상을 프라이머리 색상으로 변경
            finishButton.layer.borderWidth = 2
            finishButton.layer.borderColor = UIColor.black.cgColor
            finishButton.setTitleColor(.black, for: .normal)
            finishButton.layer.backgroundColor = UIColor.white.cgColor
            finishButton.isEnabled = true
        }
    }
    
    private func findButton(for mode: AnimalMode) -> UIButton? {
        for case let horizontalStackView as UIStackView in verticalStackView.arrangedSubviews {
            for case let button as UIButton in horizontalStackView.arrangedSubviews {
                if button.tag == mode.rawValue {
                    return button
                }
            }
        }
        return nil
    }
}

// MARK: 동물 버튼 Setup Layout
extension FavoriteAnimalViewController {
    private func setupView() {
        setupInitialView()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(verticalStackView)
        view.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(finishButton)
        horizontalStackView.addArrangedSubview(nextButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(51)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(169)
        }
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        verticalStackView.addArrangedSubview(horizontalStackView1)
        verticalStackView.addArrangedSubview(horizontalStackView2)
        verticalStackView.addArrangedSubview(horizontalStackView3)

        let modes = AnimalMode.allCases
        for (index, mode) in modes.enumerated() {
            if(mode.title == nil){
                continue
            }
            let button = UIButton()
            button.setTitle(mode.title, for: .normal)
            button.setTitleColor(.customgray2, for: .normal)
            button.setTitleColor(.primary, for: .selected)
            button.titleLabel?.font = UIFont.pretendardMedium(size: 16)
            button.layer.borderColor = UIColor.customgray2?.cgColor
            button.layer.borderWidth = 1
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 10
            button.tag = mode.rawValue
            button.addTarget(self, action: #selector(animalButtonTapped(_:)), for: .touchUpInside)
            
            // index를 통해 버튼을 적절한 verticalStackView에 추가합니다.
            if index < 2 {
                horizontalStackView1.addArrangedSubview(button)
            } else if index < 4 {
                horizontalStackView2.addArrangedSubview(button)
            }
            else
            {
                horizontalStackView3.addArrangedSubview(button)
            }
        }
    }
}

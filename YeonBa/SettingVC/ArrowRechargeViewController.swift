import UIKit
import SnapKit
import Then

class ArrowRechargeViewController: UIViewController {
    
    private let descriptionLabel = UILabel().then {
        $0.text = "화살 무료충전소에서 광고를 시청하면 화살 5개가 충전 됩니다. 하루에 화살 무료 충전소를 최대 3개까지 이용 가능합니다."
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    private let rechargeStationTitleLabel = UILabel().then {
        $0.text = "화살충전소"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    private var rechargeOptionButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupRechargeOptionButtons()
        setupLayout()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "화살 충전"
    }
    
    private func setupRechargeOptionButtons() {
        rechargeOptionButtons = (1...3).map { index in
            let button = UIButton().then {
                $0.setTitle("화살 무료 충전소 \(index)", for: .normal)
                $0.backgroundColor = index == 1 ? .systemPink : .lightGray
                $0.setTitleColor(.white, for: .normal)
                $0.layer.cornerRadius = 30
                $0.isEnabled = index == 1
                $0.tag = index
                $0.addTarget(self, action: #selector(rechargeOptionButtonTapped), for: .touchUpInside)
            }
            return button
        }
    }
    private let nextChargeButton = UIButton().then {
            $0.setTitle(" 남은 화살 수: 31개", for: .normal)
            $0.backgroundColor = .systemPink
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 15
            $0.setImage(UIImage(named: "arrowProfile")?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .white
            $0.contentHorizontalAlignment = .center
        }
    
    private func setupLayout() {
        view.addSubview(rechargeStationTitleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(nextChargeButton)
        rechargeOptionButtons.forEach(view.addSubview)
        
        rechargeStationTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(62)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(rechargeStationTitleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        nextChargeButton.snp.makeConstraints { make in
                    make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(170)
                    make.height.equalTo(40)
                }
        
        var previousButton: UIButton?
        for button in rechargeOptionButtons {
            button.snp.makeConstraints { make in
                if let previous = previousButton {
                    make.top.equalTo(previous.snp.bottom).offset(24)
                } else {
                    make.top.equalTo(nextChargeButton.snp.bottom).offset(73)
                }
                make.centerX.equalToSuperview()
                make.width.equalTo(350)
                make.height.equalTo(80)
            }
            previousButton = button
        }
    }
    
    @objc private func rechargeOptionButtonTapped(sender: UIButton) {
        if sender.tag < rechargeOptionButtons.count {
            let nextButton = rechargeOptionButtons[sender.tag]
            nextButton.isEnabled = true
            nextButton.backgroundColor = .systemPink
        }
        sender.backgroundColor = .lightGray
        sender.isEnabled = false
    }
}

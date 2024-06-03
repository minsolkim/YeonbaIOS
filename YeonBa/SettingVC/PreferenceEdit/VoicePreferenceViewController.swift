import UIKit
import SnapKit
import Then

protocol VoicePreferenceViewControllerDelegate: AnyObject {
    func voicePreferenceSelected(_ voiceType: String)
}

class VoicePreferenceViewController: UIViewController {

    weak var delegate: VoicePreferenceViewControllerDelegate?
    private var selectedVoiceType: String?

    let voiceLabel = UILabel().then {
        $0.text = "음역대"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 24)
    }
    
    private let lowVoiceButton = UIButton().then {
        $0.setTitle("저음", for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
    }

    private let midVoiceButton = UIButton().then {
        $0.setTitle("중음", for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
    }

    private let highVoiceButton = UIButton().then {
        $0.setTitle("고음", for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
    }

    let doneButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.lightGray, for: .normal) // Initially disabled color
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 15)
        $0.layer.cornerRadius = 20
        $0.layer.borderColor = UIColor.lightGray.cgColor // Initially disabled border color
        $0.layer.borderWidth = 1
        $0.layer.masksToBounds = true
        $0.isEnabled = false // Initially disabled
    }
    
    let cancelButton = ActualGradientButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 15)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        layoutView()
        setupActions()
        setupModalPresentationStyle()
    }

    private func setupView() {
        view.backgroundColor = .white
        [voiceLabel, lowVoiceButton, midVoiceButton, highVoiceButton, doneButton, cancelButton].forEach(view.addSubview)
    }

    private func layoutView() {
        voiceLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(20)
        }

        let buttonStack = UIStackView(arrangedSubviews: [lowVoiceButton, midVoiceButton, highVoiceButton])
        buttonStack.axis = .vertical
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 10
        view.addSubview(buttonStack)
        
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(voiceLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(153)  // 51 * 3
        }

        doneButton.snp.makeConstraints { make in
            make.top.equalTo(buttonStack.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-5)
            make.height.equalTo(50)
        }

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(buttonStack.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.centerX).offset(5)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

    private func setupActions() {
        [lowVoiceButton, midVoiceButton, highVoiceButton].forEach {
            $0.addTarget(self, action: #selector(voiceTypeSelected(_:)), for: .touchUpInside)
        }
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
    }

    @objc private func voiceTypeSelected(_ sender: UIButton) {
        [lowVoiceButton, midVoiceButton, highVoiceButton].forEach { button in
            button.layer.borderColor = UIColor.gray.cgColor
            button.setTitleColor(.black, for: .normal)
        }

        sender.layer.borderColor = UIColor.primary?.cgColor
        sender.setTitleColor(.primary, for: .normal)
        selectedVoiceType = sender.title(for: .normal)
        updateDoneButton(enabled: true)
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func doneAction() {
        if let selectedVoiceType = selectedVoiceType {
            delegate?.voicePreferenceSelected(selectedVoiceType)
        }
        dismiss(animated: true, completion: nil)
    }
    

    private func updateDoneButton(enabled: Bool) {
        doneButton.isEnabled = enabled
        doneButton.setTitleColor(enabled ? .black : .lightGray, for: .normal)
        doneButton.layer.borderColor = enabled ? UIColor.black.cgColor : UIColor.lightGray.cgColor
    }

    private func setupModalPresentationStyle() {
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
}

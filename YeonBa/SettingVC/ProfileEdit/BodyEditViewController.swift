import UIKit
import SnapKit
import Then

protocol BodyEditViewControllerDelegate: AnyObject {
    func didSelectBodyType(_ type: String)
}

class BodyEditViewController: UIViewController {
    
    weak var delegate: BodyEditViewControllerDelegate?
    
    private let bodyLabel = UILabel().then {
        $0.text = "체형"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 24)
    }

    private let bodyTypes = ["마른체형", "보통체형", "조금통통", "통통체형"]
    private var bodyTypeButtons: [UIButton] = []
    private var selectedBodyType: String?
    
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
        setupBodyTypeButtons()
        layoutView()
        setupActions()
    }

    private func setupBodyTypeButtons() {
        bodyTypeButtons = bodyTypes.map { type in
            let button = UIButton().then {
                $0.setTitle(type, for: .normal)
                $0.backgroundColor = .white
                $0.setTitleColor(.black, for: .normal)
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.black.cgColor
                $0.layer.cornerRadius = 8
                $0.addTarget(self, action: #selector(bodyTypeSelected(_:)), for: .touchUpInside)
            }
            return button
        }
    }

    private func layoutView() {
        view.addSubview(bodyLabel)
        let buttonStack = UIStackView(arrangedSubviews: bodyTypeButtons)
        buttonStack.axis = .vertical
        buttonStack.spacing = 10
        buttonStack.distribution = .fillEqually

        let actionStack = UIStackView(arrangedSubviews: [doneButton, cancelButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 10
        actionStack.distribution = .fillEqually

        view.addSubview(buttonStack)
        view.addSubview(actionStack)

        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(20)
        }

        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(204)
        }

        actionStack.snp.makeConstraints { make in
            make.top.equalTo(buttonStack.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }

    private func setupActions() {
        doneButton.addTarget(self, action: #selector(dismissWithSelection), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissWithoutSelection), for: .touchUpInside)
    }

    @objc private func bodyTypeSelected(_ sender: UIButton) {
        // Reset all buttons to default state first
            bodyTypeButtons.forEach {
                $0.backgroundColor = .white
                $0.setTitleColor(.black, for: .normal)
                $0.layer.borderColor = UIColor.black.cgColor
            }

            // Now update the selected button
            sender.backgroundColor = .white // If you want to change background color on selection, adjust this
            sender.setTitleColor(UIColor.primary, for: .normal) // Make sure UIColor.primary is defined, otherwise use a specific color
            sender.layer.borderColor = UIColor.primary?.cgColor // Similarly, ensure UIColor.primary is correctly defined

            selectedBodyType = sender.title(for: .normal) // Save the selected type
            updateDoneButton(enabled: true) 
    }
    
 

    @objc private func dismissWithSelection() {
        if let type = selectedBodyType {
            delegate?.didSelectBodyType(type)
        }
        dismiss(animated: true, completion: nil)
    }

    @objc private func dismissWithoutSelection() {
        dismiss(animated: true, completion: nil)
    }
       
   private func updateDoneButton(enabled: Bool) {
       doneButton.isEnabled = enabled
       doneButton.setTitleColor(enabled ? .black : .lightGray, for: .normal)
       doneButton.layer.borderColor = enabled ? UIColor.black.cgColor : UIColor.lightGray.cgColor
   }

}

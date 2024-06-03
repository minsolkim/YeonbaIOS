import UIKit
import SnapKit
import Then

protocol MBTIPreferenceViewControllerDelegate: AnyObject {
    func didSelectMBTI1(_ type: String)
}
class MBTIPreferenceViewController: UIViewController {
    
    weak var delegate: MBTIPreferenceViewControllerDelegate?
    private var selectedmbtiType: String?
    
    private let mbtiLabel = UILabel().then {
        $0.text = "Mbti"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 24)
    }
    
    
    private let mbtiTypes = [
        "INTJ", "INTP", "ENTJ", "ENTP",
        "INFJ", "INFP", "ENFJ", "ENFP",
        "ISTJ", "ISFJ", "ESTJ", "ESFJ",
        "ISTP", "ISFP", "ESTP", "ESFP"
    ]
    private var mbtiButtons: [UIButton] = []
    
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
        setupMBTIButtons()
        layoutView()
        setupActions()
    }
    
    private func setupMBTIButtons() {
        mbtiButtons = mbtiTypes.map { type in
            let button = UIButton().then {
                $0.setTitle(type, for: .normal)
                $0.backgroundColor = .white
                $0.setTitleColor(.black, for: .normal)
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.black.cgColor
                $0.layer.cornerRadius = 8
                $0.addTarget(self, action: #selector(mbtiSelected(_:)), for: .touchUpInside)
            }
            return button
        }
    }
    
    private func layoutView() {
        
        view.addSubview(mbtiLabel)
        
        let gridStack = UIStackView(arrangedSubviews: mbtiButtons.chunked(into: 4).map { row in
            let rowStack = UIStackView(arrangedSubviews: row)
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 10
            return rowStack
        })
        gridStack.axis = .vertical
        gridStack.spacing = 10

        view.addSubview(gridStack)
        view.addSubview(cancelButton)
        view.addSubview(doneButton)

        mbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(20)
        }

        gridStack.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        doneButton.snp.makeConstraints { make in
            make.top.equalTo(gridStack.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.height.equalTo(50)
        }

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(gridStack.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        doneButton.addTarget(self, action: #selector(dismissWithSelection), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissWithoutSelection), for: .touchUpInside)
    }

    @objc private func mbtiSelected(_ sender: UIButton) {

        mbtiButtons.forEach {
            $0.backgroundColor = .white
            $0.setTitleColor(.black, for: .normal)
            $0.layer.borderColor = UIColor.black.cgColor
        }
         
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(.primary, for: .normal)
        sender.layer.borderColor = UIColor.primary?.cgColor
        
        
        selectedmbtiType = sender.title(for: .normal)
        
        updateDoneButton(enabled: true)
    }
    
    

    

    @objc private func dismissWithSelection() {
        if let type = selectedmbtiType {
            print("Selected type: \(type)")
            delegate?.didSelectMBTI1(type)
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

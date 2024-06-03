import UIKit
import SnapKit
import Then

protocol FaceEditViewControllerDelegate: AnyObject {
    func didSelectFaceType(_ type: String)
}

class FaceEditViewController: UIViewController {
    
    weak var delegate: FaceEditViewControllerDelegate?
    private var selectedFaceType: String?
    
    private let faceLabel = UILabel().then {
        $0.text = "얼굴상"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 24)
    }
    
    private let faceTypes = ["강아지상", "고양이상", "사슴상", "황소상", "여우상", "곰상"]
    private var faceTypeButtons: [UIButton] = []
    
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
        setupFaceTypeButtons()
        layoutView()
        setupActions()
    }
    
    private func setupFaceTypeButtons() {
        faceTypeButtons = faceTypes.map { type in
            let button = UIButton().then {
                $0.setTitle(type, for: .normal)
                $0.backgroundColor = .white
                $0.setTitleColor(.black, for: .normal)
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.black.cgColor
                $0.layer.cornerRadius = 8
                $0.addTarget(self, action: #selector(faceTypeSelected(_:)), for: .touchUpInside)
            }
            return button
        }
    }
    
    private func layoutView() {
        let gridStack = UIStackView(arrangedSubviews: faceTypeButtons.chunked(into: 2).map { row in
            let rowStack = UIStackView(arrangedSubviews: row)
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 10
            return rowStack
        })
        gridStack.axis = .vertical
        gridStack.spacing = 10

        view.addSubview(faceLabel)
        view.addSubview(gridStack)
        view.addSubview(doneButton)
        view.addSubview(cancelButton)

        faceLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(20)
        }

        gridStack.snp.makeConstraints { make in
            make.top.equalTo(faceLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(gridStack.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }

        doneButton.snp.makeConstraints { make in
            make.top.equalTo(gridStack.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        doneButton.addTarget(self, action: #selector(dismissWithSelection), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissWithoutSelection), for: .touchUpInside)
    }

    @objc private func faceTypeSelected(_ sender: UIButton) {
            // Reset all buttons to default state
            faceTypeButtons.forEach {
                $0.backgroundColor = .white
                $0.setTitleColor(.black, for: .normal)
                $0.layer.borderColor = UIColor.black.cgColor
            }
            
            // Highlight the selected button
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(.primary, for: .normal)
            sender.layer.borderColor = UIColor.primary?.cgColor
            
            // Store the selected type
            selectedFaceType = sender.title(for: .normal)
            updateDoneButton(enabled: true)
        }

    
        @objc private func dismissWithSelection() {
            if let type = selectedFaceType {
                print("Selected type: \(type)")
                delegate?.didSelectFaceType(type)
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

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, self.count)])
        }
    }
}

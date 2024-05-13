import UIKit
import SnapKit
import Then

protocol BodyShapeViewControllerDelegate: AnyObject {
    func didSelectBodyShape(_ bodyShape: String)
}

class BodyShapeViewController: UIViewController {
    weak var delegate: BodyShapeViewControllerDelegate?
    var selectedBodyShapeButton: UIButton?
    var selectedBodyShape: String?  // 선택된 체형을 저장할 변수
    
    let bodyshapeLabel = UILabel().then {
        $0.text = "체형"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 24)
    }
    
    let promptLabel = UILabel().then {
        $0.text = "프로필에 체형을 추가해보세요."
        $0.textColor = .gray
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 20)
    }
    
    let bodyShapeContainer = UIView().then {
        $0.backgroundColor = .white
    }
    
    let bodyShapeOptions: [String] = ["마른체형", "보통체형", "조금통통", "통통체형"]
    
    let doneButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.black, for: .normal) // 버튼의 글씨색을 검정색으로 설정
        $0.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(bodyshapeLabel)
        view.addSubview(promptLabel)
        view.addSubview(bodyShapeContainer)
        view.addSubview(doneButton)
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        bodyshapeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(51)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(24)
        }
        
        promptLabel.snp.makeConstraints { make in
            make.top.equalTo(bodyshapeLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        bodyShapeContainer.snp.makeConstraints { make in
            make.top.equalTo(promptLabel.snp.bottom).offset(40)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        var previousButton: UIButton?
        
        for (index, bodyShape) in bodyShapeOptions.enumerated() {
            let button = UIButton(type: .system).then {
                $0.setTitle(bodyShape, for: .normal)
                $0.setTitleColor(.black, for: .normal)
                $0.titleLabel?.font = UIFont.pretendardMedium(size: 16)
                $0.tag = index
                $0.backgroundColor = .white // 배경색을 흰색으로 설정
                $0.layer.borderWidth = 1.0
                $0.layer.borderColor = UIColor.gray.cgColor
                $0.layer.cornerRadius = 10 // 버튼의 모서리를 둥글게
                $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16) // 내부 여백 설정
                $0.addTarget(self, action: #selector(bodyShapeSelected), for: .touchUpInside)
                
            }
            
            bodyShapeContainer.addSubview(button)
            
            button.snp.makeConstraints { make in
                make.top.equalTo(previousButton?.snp.bottom ?? bodyShapeContainer.snp.top).offset(10) // 이전 버튼의 아래에 10pt 간격
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(44) // 버튼의 높이
            }
            
            previousButton = button // 이전 버튼을 현재 버튼으로 업데이트
        }
        
        // 마지막 버튼이면 바닥에 붙도록 설정
        previousButton?.snp.makeConstraints { make in
            make.bottom.lessThanOrEqualToSuperview() // 바닥에 붙지 않고, 더 많은 버튼이 있으면 간격을 줄 수 있음
        }
        
    }
    
    @objc private func bodyShapeSelected(sender: UIButton) {
        // sender의 태그가 배열 범위 내에 있는지 확인하여 배열 범위를 벗어나는 오류를 방지합니다.
        guard sender.tag < bodyShapeOptions.count else {
            print("Invalid selection")
            return
        }

        // sender의 태그를 사용하여 선택된 체형을 가져옵니다.
        let selectedShape = bodyShapeOptions[sender.tag]

        // 이전에 선택된 버튼이 있다면, 그 버튼의 스타일을 초기화합니다.
        if let previousButton = selectedBodyShapeButton {
            previousButton.layer.borderColor = UIColor.gray.cgColor
            previousButton.setTitleColor(.black, for: .normal)
        }

        // 현재 선택된 버튼의 스타일을 업데이트합니다.
        sender.layer.borderColor = UIColor.red.cgColor
        sender.setTitleColor(.red, for: .normal)

        // 현재 선택된 버튼을 저장합니다.
        selectedBodyShapeButton = sender

        // 델리게이트를 통해 선택된 체형을 알립니다.
        delegate?.didSelectBodyShape(selectedShape)
    }
    
    @objc private func dismissModal() {
        // 완료 버튼을 누르면, 선택된 체형이 있을 경우에만 모달을 닫습니다.
        if selectedBodyShapeButton != nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            // 사용자가 아무 체형도 선택하지 않았을 경우에는 여기서 경고 메시지를 표시할 수 있습니다.
            // 예: "체형을 선택해주세요."
        }
    }
    private func updateButtonStyles(_ selectedButton: UIButton) {
        for case let button as UIButton in bodyShapeContainer.subviews {
            button.layer.borderColor = UIColor.gray.cgColor
            button.setTitleColor(.black, for: .normal)
        }
        selectedButton.layer.borderColor = UIColor.red.cgColor
        selectedButton.setTitleColor(.red, for: .normal)
    }
}

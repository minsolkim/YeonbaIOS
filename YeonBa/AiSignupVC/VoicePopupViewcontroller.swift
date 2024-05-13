import UIKit
import SnapKit
import Then

class VoicePopupViewcontroller: UIViewController {
      private let popupView: VoicePopupView
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ...
        setupPopupViewActions()
    }
    
    init(title: String, desc: String, navigation: UINavigationController?) {
        self.popupView = VoicePopupView(title: title, desc: desc, navigation: navigation)
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .clear
        self.view.addSubview(self.popupView)
        self.popupView.snp.makeConstraints {
          $0.edges.equalToSuperview()
        }
      }
    
    private func setupPopupViewActions() {
            popupView.onDoneButtonTapped = { [weak self] in
                // 이 부분에서 dismiss를 호출하여 팝업을 닫습니다.
                self?.dismiss(animated: true, completion: nil)
            }
        }
  
  required init?(coder: NSCoder) { fatalError() }
}


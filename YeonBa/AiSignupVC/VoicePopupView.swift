
import UIKit
import SnapKit
import Then
import SwiftKeychainWrapper
import Alamofire
class VoicePopupView: UIView {
    var onDoneButtonTapped: (() -> Void)?
    
    private let popupView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.pretendardBold(size: 26)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    private let descLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = UIFont.pretendardMedium(size: 18)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    private let doneBtn = ActualGradientButton().then {
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
    }
    var navigation : UINavigationController?

    
    // MARK: - Actions
    @objc func doneTapped() {
        let selectVC = PhotoSelectionViewController()
        navigation?.pushViewController(selectVC, animated: true)
        
        onDoneButtonTapped?()
    }



    init(title: String, desc: String, navigation: UINavigationController?, leftButtonTitle: String = "취소", rightButtonTitle: String = "완료") {
        self.titleLabel.text = title
        self.descLabel.text = desc
        self.navigation = navigation
        super.init(frame: .zero)
        
        self.backgroundColor = .black.withAlphaComponent(0.3)
        self.addSubview(self.popupView)
        [self.titleLabel, self.descLabel, self.doneBtn]
            .forEach(self.popupView.addSubview(_:))
        
        self.popupView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(353)
        }
        self.titleLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(46)
            make.centerX.equalToSuperview()
        }
        self.descLabel.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
        }
        self.doneBtn.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(56)
        }
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}

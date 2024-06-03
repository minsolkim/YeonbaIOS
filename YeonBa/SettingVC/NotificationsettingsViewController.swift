import UIKit
import SnapKit
import Then

class NotificationsettingsViewController: UIViewController {
    
    // MARK: - UI Components
    private let pushNotificationLabel = UILabel().then {
        $0.text = "푸시 알림"
        $0.font = UIFont.pretendardSemiBold(size: 20)
    }
    
    private let pushNotificationSwitch = UISwitch().then {
        $0.isOn = true
        $0.onTintColor = UIColor(named: "primary")
    }
    
    private let detailedPushNotificationLabel = UILabel().then {
        $0.text = "채팅 요청/수락 알림"
        $0.font = UIFont.pretendardSemiBold(size: 20)
    }
    
    private let detailedPushNotificationSwitch = UISwitch().then {
        $0.isOn = true
        $0.onTintColor = UIColor(named: "primary")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(pushNotificationLabel)
        view.addSubview(pushNotificationSwitch)
        view.addSubview(detailedPushNotificationLabel)
        view.addSubview(detailedPushNotificationSwitch)
    }
    
    private func setupConstraints() {
        pushNotificationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
        }
        
        pushNotificationSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(pushNotificationLabel.snp.centerY)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
        
        detailedPushNotificationLabel.snp.makeConstraints { make in
            make.top.equalTo(pushNotificationLabel.snp.bottom).offset(20)
            make.left.equalTo(pushNotificationLabel.snp.left)
        }
        
        detailedPushNotificationSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(detailedPushNotificationLabel.snp.centerY)
            make.right.equalTo(pushNotificationSwitch.snp.right)
        }
    }
}

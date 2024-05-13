import UIKit
import SnapKit
import Then
// 화살 알림 셀 (Arrow Notification Cell)
class ArrowNotificationCell: UITableViewCell {
    
    // MARK: - UI Components
    let profileImageView = UIImageView().then{
        $0.image = UIImage(named: "GuideGoodImage1")
        $0.layer.cornerRadius = 20
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    let messageLabel = UILabel().then{
        $0.text = "친친님이 화살을 보냈어요!"
        $0.font = UIFont.pretendardSemiBold(size: 16)
    }
    let actionButton = UIButton().then{
        $0.setTitle("프로필 보러가기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardRegular(size: 13)
        $0.layer.cornerRadius = 17
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.4
        $0.backgroundColor = UIColor.white
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(profileBtnTapped), for: .touchUpInside)
    }
    let timeLabel = UILabel().then{
        $0.text = "3분 전"
        $0.font = UIFont.pretendardRegular(size: 13)
        $0.textColor = .lightGray
    }
    let alarmIcon = UIImageView().then {
        $0.image = UIImage(named: "AlarmIcon")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8.34, leading: 10.0, bottom: 8.34, trailing: 10.0)
        actionButton.configuration = configuration
        addSubViews()
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
        configUI()
    }
    
    //MARK: - Actions
    @objc func profileBtnTapped() {
        print("profileBtnTapped tapped")
    }
    //MARK: - UI Layout
    func addSubViews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(messageLabel)
        contentView.addSubview(actionButton)
        contentView.addSubview(timeLabel)
        contentView.addSubview(alarmIcon)
    }
    
    func configUI() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(40) // Assuming a square image
        }
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).offset(8)
            make.leading.equalTo(profileImageView.snp.trailing).offset(15)
        }
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(8)
            make.leading.equalTo(messageLabel.snp.leading)
            
        }
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.equalToSuperview().offset(-20)
        }
        alarmIcon.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(10)
        }
    }
}

import UIKit
import SnapKit
import Then
// 화살 알림 셀 (Arrow Notification Cell)
class ChattingListCell: UITableViewCell {
    //MARK: - UI Components
    let profileImageView = UIImageView().then{
        $0.image = UIImage(named: "woosuck")
        $0.layer.cornerRadius = 25
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    let nameLabel = UILabel().then{
        $0.text = "변우석"
        $0.font = UIFont.pretendardSemiBold(size: 18)
    }
    let messegeLabel = UILabel().then{
        $0.text = "오늘 밥 먹었니?"
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textColor = .customgray4
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
        addSubViews()
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
        configUI()
    }
    
    //MARK: - UI Layout
    func addSubViews() {
        contentView.addSubviews(profileImageView,nameLabel,messegeLabel,timeLabel,alarmIcon)
        
        }
    
    func configUI() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(50) // Assuming a square image
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(9)
        }
        messegeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel.snp.leading)
            
        }
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalToSuperview().offset(-20)
        }
        alarmIcon.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
        }
    }
}

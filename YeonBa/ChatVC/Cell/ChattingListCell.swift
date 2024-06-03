import UIKit
import SnapKit
import Then
import Kingfisher

// 화살 알림 셀 (Arrow Notification Cell)
class ChattingListCell: UITableViewCell {
    static let identifier = "ChattingListCell"
    //MARK: - UI Components
    let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "woosuck")
        $0.layer.cornerRadius = 25
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    let nameLabel = UILabel().then {
        $0.font = UIFont.pretendardSemiBold(size: 18)
    }
    let messegeLabel = UILabel().then {
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textColor = .customgray4
    }
    let timeLabel = UILabel().then {
        $0.font = UIFont.pretendardRegular(size: 13)
        $0.textColor = .lightGray
    }
    let unreadContainerView = UIView().then {
        $0.backgroundColor = .primary
        $0.layer.cornerRadius = 11
        $0.layer.masksToBounds = true
    }
    let unreadLabel = UILabel().then {
        $0.text = "5"
        $0.backgroundColor = .clear // Label 자체의 배경은 투명하게 설정
        $0.textColor = .white
        $0.font = .pretendardMedium(size: 13)
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
        contentView.addSubviews(profileImageView, nameLabel, messegeLabel, unreadContainerView, timeLabel)
        unreadContainerView.addSubview(unreadLabel)
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
        unreadContainerView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(22)
            make.height.equalTo(22)
            make.top.equalToSuperview().offset(20)
        }
        unreadLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(with model: ChatListResponse) {
        
        nameLabel.text = model.partnerName
        messegeLabel.text = model.lastMessage
        unreadLabel.text = model.unreadMessageNumber.map { "\($0)" } ?? "0"
        // 서버에서 받아온 날짜를 현재 시간 기준으로 변환하여 표시
        if let dateString = model.lastMessageAt {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            var date: Date?
            if dateString.contains(".") {
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
                date = dateFormatter.date(from: dateString)
            }
            if date == nil {
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                date = dateFormatter.date(from: dateString)
            }
            
            if let date = date {
                let timeAgo = date.toRelativeString()
                timeLabel.text = timeAgo
            } else {
                timeLabel.text = "Invalid Date"
            }
        }
        // Profile 이미지 로딩 및 표시
        var profilePhotoUrl = model.partnerProfileImageUrl
        if let url = URL(string: Config.s3URLPrefix + profilePhotoUrl) {
            print("Loading image from URL: \(url)")
            profileImageView.kf.setImage(with: url)
        } else {
            print("Invalid URL: \(Config.s3URLPrefix + profilePhotoUrl)")
        }
    }
}
// 상대시간 계산하기
extension Date {
    /// 오늘 날짜를 기준으로 상대시간을 계산하여 문자열로 반환한다.
    /// - 예: 12시간 전, 10분 전
    func toRelativeString() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .short
        let dateToString = formatter.localizedString(for: self, relativeTo: .now)
        return dateToString
    }
}

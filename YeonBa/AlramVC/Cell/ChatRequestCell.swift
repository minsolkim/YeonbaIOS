import UIKit
import SnapKit
import Then

// 채팅 요청 알림 셀 (Chat Request Cell)
class ChatRequestCell: ArrowNotificationCell {
    //MARK: - UI Components
    let rejectButton = UIButton()
    
    //MARK: - UI Layout
    override func configUI() {
        super.configUI()
        messageLabel.text = "친친님이 채팅을 요청했어요!"
        
        actionButton.setTitle("수락", for: .normal)
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8.34, leading: 10.0, bottom: 8.34, trailing: 10.0)
        rejectButton.configuration = configuration
        
        rejectButton.setTitle("거절", for: .normal)
        rejectButton.setTitleColor(.red, for: .normal)
        rejectButton.setTitleColor(UIColor.black, for: .normal)
        rejectButton.titleLabel?.font = UIFont.pretendardRegular(size: 13)
        rejectButton.layer.cornerRadius = 17
        rejectButton.layer.borderColor = UIColor.black.cgColor
        rejectButton.layer.borderWidth = 1.4
        rejectButton.backgroundColor = UIColor.white
        rejectButton.layer.masksToBounds = true
        rejectButton.addTarget(self, action: #selector(rejectBtnTapped), for: .touchUpInside)
        rejectButton.snp.makeConstraints { make in
            make.centerY.equalTo(actionButton.snp.centerY)
            make.leading.equalTo(actionButton.snp.trailing).offset(10)
        }
    }
    
    //MARK: - Actions
    @objc func rejectBtnTapped() {
        print("rejectBtnTapped tapped")
    }
    override func addSubViews() {
        super.addSubViews()
        contentView.addSubview(rejectButton)
    }
}

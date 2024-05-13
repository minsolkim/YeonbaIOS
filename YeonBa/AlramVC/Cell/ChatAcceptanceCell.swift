import UIKit
import SnapKit
import Then

// 채팅 수락 알림 셀 (Chat Acceptance Cell)
class ChatAcceptanceCell: ArrowNotificationCell {
    //MARK: - UI Layout
    override func configUI() {
        super.configUI() // 부모 클래스의 configUI를 호출하여 기본 레이아웃을 설정합니다.
        
        messageLabel.text = "친친님이 채팅을 수락했어요!"
        actionButton.setTitle("채팅하러 가기", for: .normal)
        actionButton.addTarget(self, action: #selector(chatBtnTapped), for: .touchUpInside)
    }
    //MARK: - Actions
    @objc func chatBtnTapped() {
        print("chatBtnTapped tapped")
    }
}

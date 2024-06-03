//
//  Notification.swift
//  YeonBa
//
//  Created by 김민솔 on 5/15/24.
//

import Foundation

struct Notification: Codable {
    let notificationType: String
    let content : String
    let senderId: Int
    let senderProfilePhotoUrl: String
    let senderNickname: String
    let createdAt: String
}

extension String {
    func timeAgoSinceDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        guard let date = dateFormatter.date(from: self) else { return "" }

        let interval = Date().timeIntervalSince(date)
        
        let minute = 60.0
        let hour = 3600.0
        let day = 86400.0
        let week = 604800.0

        if interval < minute {
            return "\(Int(interval))초 전"
        } else if interval < hour {
            return "\(Int(interval / minute))분 전"
        } else if interval < day {
            return "\(Int(interval / hour))시간 전"
        } else if interval < week {
            return "\(Int(interval / day))일 전"
        } else {
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "yyyy-MM-dd"
            return dateFormatterPrint.string(from: date)
        }
    }
}

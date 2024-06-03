//
//  NotificationData.swift
//  YeonBa
//
//  Created by 김민솔 on 5/15/24.
//

import Foundation

struct NotificationDataResponse: Codable {
    let notifications: [Notifications]
    let totalPages: Int
    let totalElements: Int
    let isFirst: Bool
    let isLast: Bool
}

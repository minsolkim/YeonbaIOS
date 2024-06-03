//
//  NotificationAcceptResponse.swift
//  YeonBa
//
//  Created by jin on 5/30/24.
//

import Foundation

struct NotificationAcceptResponse: Codable {
    let chatRoomId : Int?
    let profilePhotoUrl: String?
    let nickname: String?
}

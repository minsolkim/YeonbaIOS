//
//  ChatResponseMessage.swift
//  YeonBa
//
//  Created by 김민솔 on 5/30/24.
//

import Foundation
import UIKit

struct ChatResponseMessage {
    let content: String
    let userId: Int
    let sentAt: String
    let userName: String

    init(content: String, userId: Int, sentAt: String, userName: String) {
        self.content = content
        self.userId = userId
        self.sentAt = sentAt
        self.userName = userName
    }
}

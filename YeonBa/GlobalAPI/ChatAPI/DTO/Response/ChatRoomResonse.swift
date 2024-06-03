//
//  ChatRoomResonse.swift
//  YeonBa
//
//  Created by 김민솔 on 5/25/24.
//

import Foundation

struct ChatRoomResonse: Codable {
    let userId : Int
    let userName : String
    let content : String
    let sentAt : String
}

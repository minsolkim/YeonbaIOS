//
//  ChatListResponse.swift
//  YeonBa
//
//  Created by 김민솔 on 5/18/24.
// 참여중인 채팅 목록 조회

import Foundation

struct ChatListResponse: Codable {
    let id : Int
    let partnerName : String?
    let partnerProfileImageUrl : String
    let unreadMessageNumber : Int?
    let lastMessage : String?
    let lastMessageAt : String?
    
}

//
//  ChatTarget.swift
//  YeonBa
//
//  Created by 김민솔 on 5/18/24.
//

import Foundation
import Alamofire


enum ChatTarget {
    case chattingList //채팅방 목록 조회
    case chatMessageList(_ queryDTO: ChatRoomIdRequest) //채팅 메시지 목록 조회
    case chatSend(_ queryDTO: ChatContentRequest)
}

extension ChatTarget: TargetType {
    
    var method: HTTPMethod {
        switch self {
        case .chattingList:
            return .get
        case .chatMessageList:
            return .get
        case .chatSend:
            return .post
        }
    }
    var path: String {
        switch self {
        case .chattingList:
            return "/chat-rooms"
        case let .chatMessageList(queryDTO):
            return "/chat-rooms/\(queryDTO.roomId)/messages"
        case .chatSend:
            return "/chat-rooms/"
        }
        
    }
    
    var parameters: RequestParams {
        switch self {
        case .chattingList:
            return .requestPlain
        case let .chatMessageList(queryDTO):
            return .requestQuery(queryDTO)
        case let .chatSend(queryDTO):
            return .requestQuery(queryDTO)
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self  {
        case .chattingList:
            return .hasToken
        case .chatMessageList:
            return .hasToken
        case .chatSend:
            return .hasToken
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .chattingList:
            return .authorization
        case .chatMessageList:
            return .authorization
        case .chatSend:
            return .authorization
        }
    }

}

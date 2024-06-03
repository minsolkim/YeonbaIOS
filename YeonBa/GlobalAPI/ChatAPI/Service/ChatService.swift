//
//  ChatService.swift
//  YeonBa
//
//  Created by 김민솔 on 5/18/24.
//

import Foundation
import Alamofire

protocol ChatServiceProtocol {
    func chatList(completion: @escaping (NetworkResult<ChatParent<ChatListResponse>>) -> Void)
    func chatRoomList(queryDTO: ChatRoomIdRequest,completion: @escaping (NetworkResult<ChatParent<ChatRoomResonse>>)->Void)
    //func roomChatList(queryDTO: ChatRoomIdRequest, completion: @escaping (NetworkResult<StatusResponse<>>) -> Void)

}

final class ChatService: APIRequestLoader<ChatTarget>, ChatServiceProtocol {
    func chatRoomList(queryDTO: ChatRoomIdRequest, completion: @escaping (NetworkResult<ChatParent<ChatRoomResonse>>) -> Void) {
        fetchData(target: .chatMessageList(queryDTO), responseData: ChatParent<ChatRoomResonse>.self, completion: completion)
    }
    
  
    func chatList(completion: @escaping (NetworkResult<ChatParent<ChatListResponse>>) -> Void) {
        fetchData(target: .chattingList, responseData: ChatParent<ChatListResponse>.self, completion: completion)
    }
}

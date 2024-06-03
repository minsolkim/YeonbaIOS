//
//  OtherProfileService.swift
//  YeonBa
//
//  Created by jin on 5/16/24.
//

import Foundation
import Alamofire

protocol OtherProfileServiceProtocol {
    func getOtherProfile(bodyDTO: OtherProfileRequest, completion: @escaping (NetworkResult<StatusResponse<OtherProfileResponse>>) -> Void)
    func report(bodyDTO: ReportRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void)
    func block(bodyDTO: BlockRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void)
    func sendArrow(bodyDTO: SendArrowRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void)
    func sendChat(bodyDTO: SendChatRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void)
    func bookmark(bodyDTO: BookmarkRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void)
    func deleteBookmark(bodyDTO: BookmarkRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void)
    func userList(bodyDTO: UserListRequest, completion: @escaping (NetworkResult<StatusResponse<UserListResponse>>) -> Void)
    func recommandUserList(completion: @escaping (NetworkResult<StatusResponse<UserListResponse>>) -> Void)
}

final class OtherProfileService: APIRequestLoader<OtherProfileTarget>, OtherProfileServiceProtocol {
    
    func getOtherProfile(bodyDTO: OtherProfileRequest, completion: @escaping (NetworkResult<StatusResponse<OtherProfileResponse>>) -> Void) {
        fetchData(target: .getOtherProfile(bodyDTO), responseData: StatusResponse<OtherProfileResponse>.self, completion: completion)
    }
    
    func report(bodyDTO: ReportRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void) {
        fetchData(target: .report(bodyDTO), responseData: StatusResponse<String?>.self, completion: completion)
    }
    
    func block(bodyDTO: BlockRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void) {
        fetchData(target: .block(bodyDTO), responseData: StatusResponse<String?>.self, completion: completion)
    }
    
    func sendArrow(bodyDTO: SendArrowRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void) {
        fetchData(target: .sendArrow(bodyDTO), responseData: StatusResponse<String?>.self, completion: completion)
    }
    
    func sendChat(bodyDTO: SendChatRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void) {
        fetchData(target: .sendChat(bodyDTO), responseData: StatusResponse<String?>.self, completion: completion)
    }
    
    func bookmark(bodyDTO: BookmarkRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void) {
        fetchData(target: .bookmark(bodyDTO), responseData: StatusResponse<String?>.self, completion: completion)
    }
    
    func deleteBookmark(bodyDTO: BookmarkRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void) {
        fetchData(target: .deleteBookmark(bodyDTO), responseData: StatusResponse<String?>.self, completion: completion)
    }
    
    func userList(bodyDTO: UserListRequest, completion: @escaping (NetworkResult<StatusResponse<UserListResponse>>) -> Void) {
        fetchData(target: .userList(bodyDTO), responseData: StatusResponse<UserListResponse>.self, completion: completion)
    }
    
    func recommandUserList(completion: @escaping (NetworkResult<StatusResponse<UserListResponse>>) -> Void) {
        fetchData(target: .recommandUserList, responseData: StatusResponse<UserListResponse>.self, completion: completion)
    }
}

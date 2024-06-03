//
//  NotificationService.swift
//  YeonBa
//
//  Created by 김민솔 on 5/15/24.
//

import Foundation
import Alamofire

protocol NotificationServiceProtocol {
    func NotificationList(queryDTO: NotificationPageRequest, completion: @escaping (NetworkResult<StatusResponse<NotificationDataResponse>>) -> Void)
    func UnreadNotification(completion: @escaping (NetworkResult<StatusResponse<NotificationResponse>>) -> Void)
    func notificationChatAccept(queryDTO: NotificationIdRequest, completion: @escaping (NetworkResult<StatusResponse<NotificationAcceptResponse>>) -> Void)
    //func NotificationPermission()
    
}

final class NotificationService: APIRequestLoader<NotificationTarget>, NotificationServiceProtocol {
    func notificationChatAccept(queryDTO: NotificationIdRequest, completion: @escaping (NetworkResult<StatusResponse<NotificationAcceptResponse>>) -> Void) {
        fetchData(target: .chatAccept(queryDTO), responseData: StatusResponse<NotificationAcceptResponse>.self, completion: completion)
    }
    
    func UnreadNotification(completion: @escaping (NetworkResult<StatusResponse<NotificationResponse>>) -> Void) {
        fetchData(target: .unread, responseData: StatusResponse<NotificationResponse>.self, completion: completion)
    }
    
    func NotificationList(queryDTO: NotificationPageRequest, completion: @escaping (NetworkResult<StatusResponse<NotificationDataResponse>>) -> Void) {
        fetchData(target: .watchIng(queryDTO), responseData: StatusResponse<NotificationDataResponse>.self , completion: completion)
    }
}

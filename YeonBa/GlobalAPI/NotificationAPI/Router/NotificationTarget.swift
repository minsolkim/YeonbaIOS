//
//  NotificationTarget.swift
//  YeonBa
//
//  Created by 김민솔 on 5/15/24.
//

import Foundation
import Alamofire


enum NotificationTarget {
    case unread
    case watchIng(_ queryDTO: NotificationPageRequest)
    case chatAccept(_ queryDTO: NotificationIdRequest)
    case permission
}

extension NotificationTarget: TargetType {
    
    var method: HTTPMethod {
        switch self {
        case .unread:
            return .get
        case .watchIng:
            return .patch
        case .chatAccept:
            return .post
        case .permission:
            return .get
        }
    }
    var path: String {
        switch self {
        case .unread:
            return "/users/notifications/unread/exists"
        case .watchIng:
            return "/users/notifications"
        case let .chatAccept(queryDTO):
            return "notifications/\(queryDTO.notificationId)/chat"
        case .permission:
            return "/users/notifications/permissions"
        }
        
    }
    
    var parameters: RequestParams {
        switch self {
        case .unread:
            return .requestPlain
        case let .watchIng(queryDTO):
            return .requestQuery(queryDTO)
        case let .chatAccept(queryDTO):
            return .requestQuery(queryDTO)
        case .permission:
            return .requestPlain
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self  {
        case .unread:
            return .hasToken
        case .watchIng:
            return .hasToken
        case .chatAccept:
            return .hasToken
        case .permission:
            return .hasToken
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .unread:
            return .authorization
        case .watchIng:
            return .authorization
        case .chatAccept:
            return .authorization
        case .permission:
            return .authorization
        }
    }

}

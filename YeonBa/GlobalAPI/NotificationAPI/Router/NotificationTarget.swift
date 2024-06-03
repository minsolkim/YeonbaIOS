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
}

extension NotificationTarget: TargetType {
    
    var method: HTTPMethod {
        switch self {
        case .unread:
            return .get
        case .watchIng:
            return .patch
        }
    }
    var path: String {
        switch self {
        case .unread:
            return "/users/notifications/unread/exists"
        case .watchIng:
            return "/users/notifications"
        }
        
    }
    
    var parameters: RequestParams {
        switch self {
        case .unread:
            return .requestPlain
        case let .watchIng(queryDTO):
            return .requestQuery(queryDTO)
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self  {
        case .unread:
            return .providerToken
        case .watchIng:
            return .providerToken
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .unread:
            return .authorization
        case .watchIng:
            return .authorization
        }
    }

}

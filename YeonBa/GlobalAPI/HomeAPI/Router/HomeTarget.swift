//
//  HomeTarget.swift
//  YeonBa
//
//  Created by jin on 5/17/24.
//

import Foundation
import Alamofire


enum HomeTarget {
    case arrowCount
    case dailyCheck
}

extension HomeTarget: TargetType {
    
    var method: HTTPMethod {
        switch self {
        case .arrowCount:
            return .get
        case .dailyCheck:
            return .post
        }
        
    }
    
    var path: String {
        switch self {
        case .arrowCount:
            return "/users/arrows"
        case .dailyCheck:
            return "/daily-check"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .arrowCount:
            return .requestPlain
        case .dailyCheck:
            return .requestPlain
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self  {
        case .arrowCount:
            return .hasToken
        case .dailyCheck:
            return .hasToken
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .arrowCount:
            return .authorization
        case .dailyCheck:
            return .authorization
        }
    }
}

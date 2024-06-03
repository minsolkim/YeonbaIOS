//
//  SearchUsersTarget.swift
//  YeonBa
//
//  Created by 김민솔 on 5/20/24.
//

import Foundation
import Alamofire

enum SearchUserTarget {
    case search(_ bodyDTO: SearchUserRequest)
}

extension SearchUserTarget: TargetType {
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .post
        }
        
    }
    
    var path: String {
        switch self {
        case .search:
            return "/users/search"
        
        }
        
    }
    
    var parameters: RequestParams {
        switch self {
        case let .search(bodyDTO):
            return .requestWithBody(bodyDTO)
        
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self  {
        case .search:
            return .hasToken
        
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .search:
            return .authorization
        }
    }

}

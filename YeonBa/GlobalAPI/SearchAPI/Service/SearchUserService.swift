//
//  SearchUserService.swift
//  YeonBa
//
//  Created by 김민솔 on 5/20/24.
//

import Foundation
import Alamofire


protocol SearchUserServiceProtocol {
    func searchUser(bodyDTO: SearchUserRequest, completion: @escaping (NetworkResult<StatusResponse<SearchDataResponse>>) -> Void)
    
}

final class SearchUserService: APIRequestLoader<SearchUserTarget>, SearchUserServiceProtocol {
    func searchUser(bodyDTO: SearchUserRequest, completion: @escaping (NetworkResult<StatusResponse<SearchDataResponse>>) -> Void) {
        fetchData(target: .search(bodyDTO), responseData: StatusResponse<SearchDataResponse>.self, completion: completion)
    }
    
}

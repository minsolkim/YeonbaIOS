//
//  LoginService.swift
//  YeonBa
//
//  Created by 김민솔 on 5/11/24.
//

import Foundation
import Alamofire

protocol LoginServiceProtocol {
    func login(bodyDTO: LoginRequest, completion: @escaping (NetworkResult<StatusResponse<LoginResponse>>) -> Void)
    func postRefreshToken(bodyDTO: RefreshRequest, completion: @escaping (NetworkResult<StatusResponse<RefreshResponse>>) -> Void)
}

final class LoginService: APIRequestLoader<SignUpTarget>, LoginServiceProtocol {
    func login(bodyDTO: LoginRequest, completion: @escaping (NetworkResult<StatusResponse<LoginResponse>>) -> Void) {
        fetchData(target: .login(bodyDTO), responseData: StatusResponse<LoginResponse>.self, completion: completion)
    }
    func postRefreshToken(bodyDTO: RefreshRequest, completion: @escaping (NetworkResult<StatusResponse<RefreshResponse>>) -> Void) {
        fetchData(target: .postRefreshToken(bodyDTO), responseData: StatusResponse<RefreshResponse>.self, completion: completion)
    }
    
}

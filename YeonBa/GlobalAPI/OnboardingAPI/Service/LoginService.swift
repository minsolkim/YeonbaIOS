//
//  LoginService.swift
//  YeonBa
//
//  Created by 김민솔 on 5/11/24.
//

import Foundation
import Alamofire

protocol LoginServiceProtocol {
    func login(bodyDTO: LoginRequest, completion: @escaping (NetworkResult<BaseResponse<LoginResponse>>) -> Void)
    func postRefreshToken(bodyDTO: RefreshRequest, completion: @escaping (NetworkResult<BaseResponse<RefreshResponse>>) -> Void)
}

final class LoginService: APIRequestLoader<SignUpTarget>, LoginServiceProtocol {
    func login(bodyDTO: LoginRequest, completion: @escaping (NetworkResult<BaseResponse<LoginResponse>>) -> Void) {
        fetchData(target: .login(bodyDTO), responseData: BaseResponse<LoginResponse>.self, completion: completion)
    }
    func postRefreshToken(bodyDTO: RefreshRequest, completion: @escaping (NetworkResult<BaseResponse<RefreshResponse>>) -> Void) {
        fetchData(target: .postRefreshToken(bodyDTO), responseData: BaseResponse<RefreshResponse>.self, completion: completion)
    }
    
}

//
//  SignUpService.swift
//  YeonBa
//
//  Created by 김민솔 on 5/6/24.
//

import Foundation
import Alamofire

protocol SignUpServiceProtocol {
    func signUp(bodyDTO: SignUpRequest, completion: @escaping (NetworkResult<BaseResponse<SignUpResponse>>) -> Void)
}

final class SignUpService: APIRequestLoader<SignUpTarget>, SignUpServiceProtocol {
    func signUp(bodyDTO: SignUpRequest, completion: @escaping (NetworkResult<BaseResponse<SignUpResponse>>) -> Void) {
        fetchData(target: .signUp(bodyDTO),
                  responseData: BaseResponse<SignUpResponse>.self, completion: completion)
    }
}

//
//  SignUpService.swift
//  YeonBa
//
//  Created by 김민솔 on 5/6/24.
//

import Foundation
import Alamofire

protocol SignUpServiceProtocol {
    func nicknameCheck(queryDTO: NicknameRequest, completion: @escaping (NetworkResult<StatusResponse<NicknameResponse>>) -> Void)
    func signUp(bodyDTO: SignUpRequest, completion: @escaping (NetworkResult<BaseResponse<SignUpResponse>>) -> Void)
    func phoneNumberCheck(queryDTO: PhoneNumberRequest,completion: @escaping (NetworkResult<StatusResponse<PhoneNumberResponse>>) -> Void)
}

final class SignUpService: APIRequestLoader<SignUpTarget>, SignUpServiceProtocol {
    func phoneNumberCheck(queryDTO: PhoneNumberRequest, completion: @escaping (NetworkResult<StatusResponse<PhoneNumberResponse>>) -> Void) {
        fetchData(target: .phoneNumberCheck(queryDTO), responseData: StatusResponse<PhoneNumberResponse>.self, completion: completion)
    }
    
    func nicknameCheck(queryDTO: NicknameRequest, completion: @escaping (NetworkResult<StatusResponse<NicknameResponse>>) -> Void) {
        fetchData(target: .nicknameCheck(queryDTO), responseData: StatusResponse<NicknameResponse>.self, completion: completion)
    }
    
    func signUp(bodyDTO: SignUpRequest, completion: @escaping (NetworkResult<BaseResponse<SignUpResponse>>) -> Void) {
        fetchData(target: .signUp(bodyDTO),
                  responseData: BaseResponse<SignUpResponse>.self, completion: completion)
    }
}

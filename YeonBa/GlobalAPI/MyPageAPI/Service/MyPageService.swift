//
//  MyPageService.swift
//  YeonBa
//
//  Created by 김민솔 on 5/23/24.
//

import Foundation
import Alamofire


protocol MyPageServiceProtocol {
    func myProfile(completion: @escaping (NetworkResult<StatusResponse<ProfileResponse>>) -> Void)
    func editProfile(bodyDTO: ProfileEditRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void)
    func profileDetail(completion: @escaping (NetworkResult<StatusResponse<ProfileDetailResponse>>) -> Void)
    func chargeArrow(completion: @escaping (NetworkResult<StatusResponse<Int?>>)-> Void)
    func blockUsers(completion: @escaping (NetworkResult<StatusResponse<BlockResponse>>)-> Void)
    func blockUsersClear(queryDTO: BlcokUserIdRequest, completion: @escaping (NetworkResult<StatusResponse<Int?>>) -> Void)
    func editPhoto(bodyDTO:PhotoEditRequest, completion: @escaping (NetworkResult<StatusResponse<Int?>>) -> Void)
}

final class MyPageService: APIRequestLoader<MyPageTarget>, MyPageServiceProtocol {
    
    func blockUsersClear(queryDTO: BlcokUserIdRequest, completion: @escaping (NetworkResult<StatusResponse<Int?>>) -> Void) {
        fetchData(target: .blcokUsersClear(queryDTO), responseData: StatusResponse<Int?>.self, completion: completion)
    }
    
    func blockUsers(completion: @escaping (NetworkResult<StatusResponse<BlockResponse>>) -> Void) {
        fetchData(target: .blockUsers, responseData: StatusResponse<BlockResponse>.self, completion: completion)
    }
    
    func chargeArrow(completion: @escaping (NetworkResult<StatusResponse<Int?>>) -> Void) {
        fetchData(target: .chargeArrow, responseData: StatusResponse<Int?>.self, completion: completion)
    }
    
    func profileDetail(completion: @escaping (NetworkResult<StatusResponse<ProfileDetailResponse>>) -> Void) {
        fetchData(target: .profileDetail , responseData: StatusResponse<ProfileDetailResponse>.self, completion: completion)
    }
    
    func editProfile(bodyDTO: ProfileEditRequest, completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void) {
        fetchData(target: .editProfile(bodyDTO), responseData: StatusResponse<String?>.self, completion: completion)
    }
    
    func myProfile(completion: @escaping (NetworkResult<StatusResponse<ProfileResponse>>) -> Void) {
        fetchData(target: .myprofile, responseData: StatusResponse<ProfileResponse>.self, completion: completion)
    }
  
    func editPhoto(bodyDTO: PhotoEditRequest, completion: @escaping (NetworkResult<StatusResponse<Int?>>) -> Void) {
        fetchData(target: .editPhoto(bodyDTO), responseData: StatusResponse<Int?>.self, completion: completion)
    }
}

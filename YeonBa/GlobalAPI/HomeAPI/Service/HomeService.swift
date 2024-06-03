//
//  HomeService.swift
//  YeonBa
//
//  Created by jin on 5/17/24.
//

import Foundation
import Alamofire

protocol HomeServiceProtocol {
    func arrowCount(completion: @escaping (NetworkResult<StatusResponse<ArrowCountResponse>>) -> Void)
    func dailyCheck(completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void)
}

final class HomeService: APIRequestLoader<HomeTarget>, HomeServiceProtocol {
    func arrowCount(completion: @escaping (NetworkResult<StatusResponse<ArrowCountResponse>>) -> Void) {
        fetchData(target: .arrowCount, responseData: StatusResponse<ArrowCountResponse>.self, completion: completion)
    }
    
    func dailyCheck(completion: @escaping (NetworkResult<StatusResponse<String?>>) -> Void) {
        fetchData(target: .dailyCheck, responseData: StatusResponse<String?>.self, completion: completion)
    }
}


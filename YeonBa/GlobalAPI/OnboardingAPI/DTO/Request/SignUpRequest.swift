//
//  SignUpRequest.swift
//  YeonBa
//
//  Created by 김민솔 on 5/3/24.
//

import Foundation

struct SignUpRequest : Codable {
    let socialId : Int
    let loginType : String
    let gender : String
    let phoneNumber : String
    let birth : String
    let nickname : String
    let height : Int?
    let bodyType : String
    let job : String
    let activityArea : String
    let mbti : String
    let vocalRange : String
    let profilePhotos : [Data]?
    let photoSyncRate : Int?
    let lookAlikeAnimal : String
    let preferredAnimal : String
    let preferredArea : String
    let preferredVocalRange : String
    let preferredAgeLowerBound : Int?
    let preferredAgeUpperBound : Int?
    let preferredHeightLowerBound : Int?
    let preferredHeightUpperBound : Int?
    let preferredBodyType : String
    let preferredMbti : String
    
}

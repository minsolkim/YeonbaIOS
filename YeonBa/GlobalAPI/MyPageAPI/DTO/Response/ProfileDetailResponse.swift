//
//  ProfileDetailResponse.swift
//  YeonBa
//
//  Created by jin on 5/27/24.
//

import Foundation

struct ProfileDetailResponse : Codable {
    var profilePhotoUrls : [String]
    var gender : String
    var birth : String
    var height : Int
    var phoneNumber : String
    var nickname : String
    var photoSyncRate : Int
    var bodyType : String
    var job : String
    var mbti : String
    var vocalRange : String
    var lookAlikeAnimal : String
    var activityArea : String
    var preferredVocalRange : String
    var preferredAnimal : String
    var preferredArea : String
    var preferredAgeLowerBound : Int
    var preferredAgeUpperBound :Int
    var preferredHeightLowerBound : Int
    var preferredHeightUpperBound : Int
    var preferredMbti : String
    var preferredBodyType : String
}

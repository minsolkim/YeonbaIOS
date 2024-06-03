//
//  ProfileEditRequest.swift
//  YeonBa
//
//  Created by jin on 5/27/24.
//


import Foundation

struct ProfileEditRequest: Codable {
    var nickname : String
    var height : Int
    var vocalRange : String
    var birth : String
    var bodyType : String
    var job : String
    var activityArea : String
    var lookAlikeAnimal : String
    var mbti : String
    var preferredAnimal : String
    var preferredArea : String
    var preferredVocalRange : String
    var preferredAgeLowerBound : Int
    var preferredAgeUpperBound : Int
    var preferredHeightLowerBound : Int
    var preferredHeightUpperBound : Int
    var preferredBodyType : String
    var preferredMbti : String
}

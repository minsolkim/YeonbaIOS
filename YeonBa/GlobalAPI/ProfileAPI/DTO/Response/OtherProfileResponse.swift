//
//  OtherProfileResponse.swift
//  YeonBa
//
//  Created by jin on 5/16/24.
//

import Foundation

struct OtherProfileResponse: Codable {
    let profilePhotosUrls: [String]
    let gender : String
    let nickname: String
    let arrows: Int
    let age : Int
    let height : Int
    let activityArea: String
    let photoSyncRate: Int
    let vocalRange: String
    let lookAlikeAnimalName: String
    let preferredAgeLowerBound : Int?
    let preferredAgeUpperBound : Int?
    let preferredHeightLowerBound : Int?
    let preferredHeightUpperBound : Int?
    let preferredMbti : String
    let preferredBodyType : String
    let alreadySentArrow : Bool
    let canChat : Bool
}

//
//  UserProfileResponse.swift
//  YeonBa
//
//  Created by jin on 5/17/24.
//
import Foundation

struct UserProfileResponse : Codable{
    let id: Int
    let profilePhotoUrl : String
    let nickname: String
    let age : Int
    let receivedArrows: Int
    let lookAlikeAnimal: String
    let photoSyncRate: Int
    let activityArea: String
    let height: Int
    let vocalRange: String
    let isFavorite : Bool
}

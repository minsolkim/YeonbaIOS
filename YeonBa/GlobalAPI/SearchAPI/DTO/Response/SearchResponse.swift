//
//  SearchResponse.swift
//  YeonBa
//
//  Created by 김민솔 on 5/20/24.
//

import Foundation

struct SearchUsers : Codable {
    let id : Int
    let profilePhotoUrl : String
    let nickname : String
    let age : Int
    let receivedArrows : Int
    let lookAlikeAnimal : String
    let photoSyncRate : Int
    let activityArea : String
    let height : Int
    let vocalRange : String
    let isFavorite : Bool
}

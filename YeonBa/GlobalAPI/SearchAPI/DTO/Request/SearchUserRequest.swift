//
//  SearchRequest.swift
//  YeonBa
//
//  Created by 김민솔 on 5/20/24.
//

import Foundation

struct SearchUserRequest : Codable {
    let page : Int
    let area : String?
    let vocalRange : String?
    let ageLowerBound : Int?
    let ageUpperBound : Int?
    let heightLowerBound : Int?
    let heightUpperBound : Int?
    let includePreferredAnimal : Bool?
}

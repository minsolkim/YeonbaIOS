//
//  UserListResponse.swift
//  YeonBa
//
//  Created by jin on 5/17/24.
//

import Foundation
struct UserListResponse : Codable {
    var users : [UserProfileResponse]
    var totalPage : Int
    var totalElements : Int
    var isFirst : Bool
    var isLast : Bool
}

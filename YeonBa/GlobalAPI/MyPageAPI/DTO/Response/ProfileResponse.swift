//
//  ProfileResponse.swift
//  YeonBa
//
//  Created by 김민솔 on 5/23/24.
//

import Foundation

struct ProfileResponse : Codable {
    let name : String
    let profileImageUrl : String
    let arrows : Int
}

//
//  LoginRequest.swift
//  YeonBa
//
//  Created by 김민솔 on 5/11/24.
//

import Foundation

struct LoginRequest: Codable {
    let socialId: Int
    let loginType: String
    let phoneNumber: String
    
}

//
//  SignUpResponse.swift
//  YeonBa
//
//  Created by 김민솔 on 5/6/24.
//

import Foundation

struct SignUpResponse: Codable {
    let jwt: String
    let jwtRefreshToken: String
}

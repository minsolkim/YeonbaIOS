//
//  LoginResponse.swift
//  YeonBa
//
//  Created by 김민솔 on 5/11/24.
//

import Foundation

struct LoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
}

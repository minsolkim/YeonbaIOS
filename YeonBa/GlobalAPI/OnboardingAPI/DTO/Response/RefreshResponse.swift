//
//  RefreshResponse.swift
//  YeonBa
//
//  Created by 김민솔 on 5/11/24.
//

import Foundation

struct RefreshResponse: Codable {
    let jwt: String
    let refreshToken: String
}

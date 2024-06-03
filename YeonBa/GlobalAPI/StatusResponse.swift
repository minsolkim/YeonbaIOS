//
//  StatusResponse.swift
//  YeonBa
//
//  Created by 김민솔 on 5/13/24.
//

import Foundation

struct StatusResponse<T: Decodable>: Decodable {
    let status: String
    let message: String?
    let data: T?
}

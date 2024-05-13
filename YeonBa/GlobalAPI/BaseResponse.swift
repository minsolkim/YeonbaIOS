//
//  BaseResponse.swift
//  YeonBa
//
//  Created by 김민솔 on 5/3/24.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let code: Int
    let message: String
    let data: T?
}

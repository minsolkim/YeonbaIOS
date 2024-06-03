//
//  SearchDataResponse.swift
//  YeonBa
//
//  Created by 김민솔 on 5/20/24.
//

import Foundation

struct SearchDataResponse : Codable {
    let users: [SearchUsers]
    let totalPage: Int
    let totalElements: Int
    let isFirst: Bool
    let isLast: Bool
}

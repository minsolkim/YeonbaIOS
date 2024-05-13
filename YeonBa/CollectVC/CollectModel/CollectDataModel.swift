//
//  CollectDataModel.swift
//  YeonBa
//
//  Created by jin on 4/29/24.
//

import Foundation

struct CollectDataModel: Codable {
    let users: [CollectDataUserModel]
    let totalPage: Int
    let totalElements: Int
    let isFirstPage: Bool
    let isLastPage: Bool
}

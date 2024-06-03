//
//  ChatParent.swift
//  YeonBa
//
//  Created by 김민솔 on 5/24/24.
//

import Foundation


struct ChatParent<T: Decodable>: Decodable {
    let status: String
    let message: String?
    let data: [T]?
}

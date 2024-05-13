//
//  NetworkResult.swift
//  YeonBa
//
//  Created by 김민솔 on 5/3/24.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkErr
    case failure
}

//
//  HTTPHeaderField.swift
//  YeonBa
//
//  Created by 김민솔 on 5/3/24.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case accessToken = "accessToken"
    case refreshtoken = "refreshtoken"
    case providerToken = "X-Provider-Token"
}

enum HTTPHeaderFieldValue: String {
    case multipartformData = "multipart/form-data"
    case json = "Application/json"
    case accessToken
}

enum HTTPHeaderType {
    case plain
    case providerToken
    case hasToken
    case refreshToken
}

@frozen
enum Authorization {
    case authorization
    case unauthorization
    case socialAuthorization
    case reAuthorization
}

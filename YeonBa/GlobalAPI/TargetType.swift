//
//  TargetType.swift
//  YeonBa
//
//  Created by 김민솔 on 5/3/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
    var headerType: HTTPHeaderType { get }
    var authorization: Authorization { get }
}

extension TargetType {
    var baseURL: String {
        return "https://api.yeonba.co.kr"
    }
    
    var headers: [String: String]? {
        switch headerType {
        case .plain:
            return [
                HTTPHeaderField.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue
            ]
        case .hasToken:
            return [
                HTTPHeaderField.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue,
                HTTPHeaderField.authentication.rawValue: "Bearer \(KeychainHandler.shared.accessToken)"
            ]
        case .refreshToken:
            return [
                HTTPHeaderField.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue,
                HTTPHeaderField.authentication.rawValue: "Bearer \(KeychainHandler.shared.refreshToken)"
            ]
        case .providerToken:
            return [
                HTTPHeaderField.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue,
                HTTPHeaderField.providerToken.rawValue: KeychainHandler.shared.providerToken
            ]
        }
    }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch authorization {
        case .authorization:
            urlRequest.setValue("Bearer \(KeychainHandler.shared.accessToken)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        case .unauthorization:
            break
        case .socialAuthorization:
            urlRequest.setValue(KeychainHandler.shared.providerToken, forHTTPHeaderField: HTTPHeaderField.providerToken.rawValue)
        case .reAuthorization:
            urlRequest.setValue(KeychainHandler.shared.refreshToken, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        
        switch headerType {
        case .plain, .hasToken, .refreshToken, .providerToken:
            urlRequest.setValue(HTTPHeaderFieldValue.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }
        
        switch parameters {
        case .requestWithBody(let request):
            let params = request?.toDictionary() ?? [:]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
            
        case .requestQuery(let request):
            var urlComponents = URLComponents(url: url.appendingPathComponent(path), resolvingAgainstBaseURL: false)
            let params = request?.toDictionary()
            urlComponents?.queryItems = params?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            urlRequest.url = urlComponents?.url
            
        case .requestQueryWithBody(let queryRequest, let bodyRequest):
            var urlComponents = URLComponents(url: url.appendingPathComponent(path), resolvingAgainstBaseURL: false)
            let queryParams = queryRequest?.toDictionary()
            urlComponents?.queryItems = queryParams?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            urlRequest.url = urlComponents?.url
            
            let bodyParams = bodyRequest?.toDictionary() ?? [:]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParams)
            
        case .requestWithMultipart(let multipartFormDataClosure):
            // 멀티파트 폼 데이터 처리
            var multipartFormData = MultipartFormData()
            multipartFormDataClosure(multipartFormData)
            
            urlRequest.httpBody = try multipartFormData.encode()
            urlRequest.setValue(multipartFormData.contentType, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            
            
        case .requestPlain:
            break
        }
        
        return urlRequest
    }
    
    
}

@frozen
enum RequestParams {
    case requestPlain
    case requestWithBody(_ paramter: Encodable?)
    case requestQuery(_ parameter: Encodable?)
    case requestQueryWithBody(_ queryParameter: Encodable?, bodyParameter: Encodable?)
    case requestWithMultipart(_ multipartFormData: (MultipartFormData) -> Void)
}

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any]
        else { return [:] }
        
        return dictionaryData
    }
}

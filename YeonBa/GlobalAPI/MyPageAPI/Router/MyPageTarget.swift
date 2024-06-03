//
//  MyPageTarget.swift
//  YeonBa
//
//  Created by 김민솔 on 5/23/24.
//

import Foundation
import Alamofire

enum MyPageTarget {
    case myprofile
    case editProfile(_ bodyDTO: ProfileEditRequest)
    case profileDetail
    case chargeArrow //화살 충전
    case blockUsers //유저 차단 목록 조회
    case blcokUsersClear(_ queryDTO: BlcokUserIdRequest) //유저 차단 해제
    case editPhoto(_ bodyDTO: PhotoEditRequest)
}

extension MyPageTarget: TargetType {
    
    var method: HTTPMethod {
        switch self {
        case .myprofile:
            return .get
        case .editProfile:
            return .patch
        case .profileDetail:
            return .get
        case .chargeArrow:
            return .post
        case .blockUsers:
            return .get
        case .blcokUsersClear:
            return .delete
        case .editPhoto:
            return .put
        }
        
    }
    
    var path: String {
        switch self {
        case .myprofile:
            return "/users/profiles"
        case .editProfile:
            return "/users/profiles"
        case .profileDetail:
            return "/users/profiles/details"
        case .chargeArrow:
            return "/users/arrows"
        case .blockUsers:
            return "/users/block"
        case let .blcokUsersClear(queryDTO):
            return "/users/\(queryDTO.userId)/block"
        case .editPhoto:
            return "/users/profile-photos"
        }
        
    }
    
    var parameters: RequestParams {
        switch self {
        case .myprofile:
            return .requestPlain
        case let .editProfile(bodyDTO):
            return .requestWithBody(bodyDTO)
        case .profileDetail:
            return .requestPlain
        case .chargeArrow:
            return .requestPlain
        case .blockUsers:
            return .requestPlain
        case let .blcokUsersClear(queryDTO):
            return .requestQuery(queryDTO)
        case let .editPhoto(bodyDTO):
            return .requestWithMultipart(bodyDTO.toMultipartFormData())
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self  {
        case .myprofile:
            return .hasToken
        case .editProfile:
            return .hasToken
        case .profileDetail:
            return .hasToken
        case .chargeArrow:
            return .hasToken
        case .blockUsers:
            return .hasToken
        case .blcokUsersClear:
            return .hasToken
        case .chargeArrow:
            return .hasToken
        case .blockUsers:
            return .hasToken
        case .blcokUsersClear:
            return .hasToken
        case .editPhoto:
            return .hasToken
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .myprofile:
            return .authorization
        case .editProfile:
            return .authorization
        case .profileDetail:
            return .authorization
        case .chargeArrow:
            return .authorization
        case .blockUsers:
            return .authorization
        case .blcokUsersClear:
            return .authorization
        case .editPhoto:
            return .authorization
        }
    }

}
extension PhotoEditRequest {
    func toMultipartFormData() -> (MultipartFormData) -> Void {
        return { formData in
            let profilePhotos = self.profilePhotos
            for (index, photo) in profilePhotos.enumerated() {
                print("Index: \(index), Photo: \(photo)")
                formData.append(photo, withName: "profilePhotos", fileName: "photo\(index).jpg", mimeType: "image/jpeg")
            }
            formData.append("\(self.photoSyncRate)".data(using: .utf8) ?? Data(), withName: "photoSyncRate")
        }
    }
}


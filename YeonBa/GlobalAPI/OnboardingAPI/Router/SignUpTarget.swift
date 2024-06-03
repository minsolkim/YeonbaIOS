//
//  SignUpTarget.swift
//  YeonBa
//
//  Created by 김민솔 on 5/6/24.
//

import Foundation
import Alamofire


enum SignUpTarget {
    case signUp(_ bodyDTO: SignUpRequest)
    case phoneNumberCheck(_ queryDTO: PhoneNumberRequest)
    case nicknameCheck(_ queryDTO: NicknameRequest)
    case login(_ bodyDTO: LoginRequest)
    case postRefreshToken(_ queryDTO: RefreshRequest)
}

extension SignUpTarget: TargetType {
    
    var method: HTTPMethod {
        switch self {
        case .signUp:
            return .post
        case .phoneNumberCheck:
            return .get
        case .nicknameCheck:
            return .get
        case .login:
            return .post
        case .postRefreshToken:
            return .post
            
        }
        
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/users/join"
        case .phoneNumberCheck:
            return "/users/phone-numbers/used"
        case .nicknameCheck:
            return "/users/nicknames/used"
        case .login:
            return "/users/login"
        case .postRefreshToken:
            return "/users/refresh"
        }
        
    }
    
    var parameters: RequestParams {
        switch self {
        case let .signUp(bodyDTO):
            return .requestWithMultipart(bodyDTO.toMultipartFormData())
        case let .phoneNumberCheck(queryDTO):
            return .requestQuery(queryDTO)
        case let .nicknameCheck(queryDTO):
            return .requestQuery(queryDTO)
        case let .login(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .postRefreshToken(queryDTO):
            return .requestQuery(queryDTO)
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self  {
        case .signUp:
            return .plain
        case .phoneNumberCheck:
            return .plain
        case .nicknameCheck:
            return .plain
        case .login:
            return .providerToken
        case .postRefreshToken:
            return .refreshToken
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .signUp:
            return .authorization
        case .phoneNumberCheck:
            return .unauthorization
        case .nicknameCheck:
            return .unauthorization
        case .login:
            return .socialAuthorization
        case .postRefreshToken:
            return .reAuthorization
        }
    }
}
extension SignUpRequest {
    func toMultipartFormData() -> (MultipartFormData) -> Void {
        return { formData in
            formData.append("\(self.socialId)".data(using: .utf8) ?? Data(), withName: "socialId")
            formData.append(self.loginType.data(using: .utf8) ?? Data(), withName: "loginType")
            formData.append(self.gender.data(using: .utf8) ?? Data(), withName: "gender")
            formData.append(self.phoneNumber.data(using: .utf8) ?? Data(), withName: "phoneNumber")
            formData.append(self.birth.data(using: .utf8) ?? Data(), withName: "birth")
            formData.append(self.nickname.data(using: .utf8) ?? Data(), withName: "nickname")
            formData.append("\(self.height ?? 0)".data(using: .utf8) ?? Data(), withName: "height")
            formData.append(self.bodyType.data(using: .utf8) ?? Data(), withName: "bodyType")
            formData.append(self.job.data(using: .utf8) ?? Data(), withName: "job")
            formData.append(self.activityArea.data(using: .utf8) ?? Data(), withName: "activityArea")
            formData.append(self.mbti.data(using: .utf8) ?? Data(), withName: "mbti")
            formData.append(self.vocalRange.data(using: .utf8) ?? Data(), withName: "vocalRange")
            formData.append("\(self.photoSyncRate ?? 0)".data(using: .utf8) ?? Data(), withName: "photoSyncRate")
            formData.append(self.lookAlikeAnimal.data(using: .utf8) ?? Data(), withName: "lookAlikeAnimal")
            formData.append(self.preferredAnimal.data(using: .utf8) ?? Data(), withName: "preferredAnimal")
            formData.append(self.preferredArea.data(using: .utf8) ?? Data(), withName: "preferredArea")
            formData.append(self.preferredVocalRange.data(using: .utf8) ?? Data(), withName: "preferredVocalRange")
            formData.append("\(self.preferredAgeLowerBound ?? 0)".data(using: .utf8) ?? Data(), withName: "preferredAgeLowerBound")
            formData.append("\(self.preferredAgeUpperBound ?? 0)".data(using: .utf8) ?? Data(), withName: "preferredAgeUpperBound")
            formData.append("\(self.preferredHeightLowerBound ?? 0)".data(using: .utf8) ?? Data(), withName: "preferredHeightLowerBound")
            formData.append("\(self.preferredHeightUpperBound ?? 0)".data(using: .utf8) ?? Data(), withName: "preferredHeightUpperBound")
            formData.append(self.preferredBodyType.data(using: .utf8) ?? Data(), withName: "preferredBodyType")
            formData.append(self.preferredMbti.data(using: .utf8) ?? Data(), withName: "preferredMbti")
            // 프로필 사진을 formData에 추가하는 경우
            print("multipartformdata 출력")
            if let profilePhotos = self.profilePhotos {
                print("Profile Photos is not empty. Count: \(profilePhotos.count)")
                for (index, photo) in profilePhotos.enumerated() {
                    print("Index: \(index), Photo: \(photo)")
                    formData.append(photo, withName: "profilePhotos", fileName: "photo\(index).jpg", mimeType: "image/jpeg")
                }
            } else {
                print("Profile Photos is nil or empty")
            }

        }
    }

}


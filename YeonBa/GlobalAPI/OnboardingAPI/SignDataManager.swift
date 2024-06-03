//
//  SignDataManager.swift
//  YeonBa
//
//  Created by 김민솔 on 5/3/24.
//

import Foundation
import SwiftKeychainWrapper

class SignDataManager {
    static let shared = SignDataManager()
    
    private init() {}
    var selectedImages: [UIImage] = []
    var essentialImage : UIImage = UIImage()
    var placeholderImage : UIImage = UIImage()
    var profilePhotos : [Data]? = []
    var selfieImage : UIImage = UIImage()
    
    var confidence: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "confidence")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "confidence")
            } else {
                UserDefaults.standard.removeObject(forKey: "confidence")
            }
        }
    }
    
    var socialId: Int? {
        get {
            return KeychainWrapper.standard.integer(forKey: "socialId") // keychain 반환
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "socialId") //keychain 저장
            } else {
                KeychainWrapper.standard.removeObject(forKey: "socialId") //keychain 삭제
            }
        }
    }
    
    var loginType: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "loginType") // keychain 반환
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "loginType") //keychain 저장
            } else {
                KeychainWrapper.standard.removeObject(forKey: "loginType") //keychain 삭제
            }
        }
    }
    
    var phoneNumber: String? {
        get {
            return UserDefaults.standard.string(forKey: "phoneNumber")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "phoneNumber")
            } else {
                UserDefaults.standard.removeObject(forKey: "phoneNumber")
            }
        }
    }
    
    var birthDate: String? {
        get {
            return UserDefaults.standard.string(forKey: "birthDate") // keychain 반환
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "birthDate") //keychain 저장
            } else {
                UserDefaults.standard.removeObject(forKey: "birthDate") //keychain 삭제
            }
        }
    }
    
    var nickName: String? {
        get {
            return UserDefaults.standard.string(forKey: "nickName")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "nickName")
            } else {
                UserDefaults.standard.removeObject(forKey: "nickName")
            }
        }
    }
    
    var gender: String? {
        get {
            return UserDefaults.standard.string(forKey: "gender")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "gender")
            } else {
                UserDefaults.standard.removeObject(forKey: "gender")
            }
        }
    }
    
    var height: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "height")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "height")
            } else {
                UserDefaults.standard.removeObject(forKey: "height")
            }
        }
    }
    
    var bodyType: String? {
        get {
            return UserDefaults.standard.string(forKey: "bodyType")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "bodyType")
            } else {
                UserDefaults.standard.removeObject(forKey: "bodyType")
            }
        }
    }
    
    var job: String? {
        get {
            return UserDefaults.standard.string(forKey: "job")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "job")
            } else {
                UserDefaults.standard.removeObject(forKey: "job")
            }
        }
    }
    
    var mbti: String? {
        get {
            return UserDefaults.standard.string(forKey: "mbti")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "mbti")
            } else {
                UserDefaults.standard.removeObject(forKey: "mbti")
            }
            
        }
    }
    
    var activityArea: String? {
        get {
            return UserDefaults.standard.string(forKey: "activityArea")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "activityArea")
            } else {
                UserDefaults.standard.removeObject(forKey: "activityArea")
            }
        }
    }
    
    var vocalRange: String? {
        get {
            return UserDefaults.standard.string(forKey: "voaclRange")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "voaclRange")
            } else {
                UserDefaults.standard.removeObject(forKey: "voaclRange")
            }
        }
    }
    
    var lookAlikeAnimal: String? {
        get {
            return UserDefaults.standard.string(forKey: "lookAlikeAnimal")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "lookAlikeAnimal")
            } else {
                UserDefaults.standard.removeObject(forKey: "lookAlikeAnimal")
            }
        }
    }
    
    var preferredAnimal:String? {
        get {
            return UserDefaults.standard.string(forKey: "preferredAnimal")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "preferredAnimal")
            } else {
                UserDefaults.standard.removeObject(forKey: "preferredAnimal")
            }
        }
    }
    
    var preferredArea: String? {
        get {
            return UserDefaults.standard.string(forKey: "preferredArea")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "preferredArea")
            } else {
                UserDefaults.standard.removeObject(forKey: "preferredArea")
            }
        }
    }
    
    var preferredVocalRange: String? {
        get {
            return UserDefaults.standard.string(forKey: "preferredVocalRange")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "preferredVocalRange")
            } else {
                UserDefaults.standard.removeObject(forKey: "preferredVocalRange")
            }
        }
    }
    
    var preferredAgeLowerBound: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "preferredAgeLowerBound")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "preferredAgeLowerBound")
            } else {
                UserDefaults.standard.removeObject(forKey: "preferredAgeLowerBound")
            }
        }
    }
    
    var preferredAgeUpperBound: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "preferredAgeUpperBound")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "preferredAgeUpperBound")
            } else {
                UserDefaults.standard.removeObject(forKey: "preferredAgeUpperBound")
            }
        }
    }
    
    var preferredBodyType: String? {
        get {
            return UserDefaults.standard.string(forKey: "preferredBodyType")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "preferredBodyType")
            } else {
                UserDefaults.standard.removeObject(forKey: "preferredBodyType")
            }
        }
    }
    
    var preferredHeightLowerBound: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "preferredHeightLowerBound")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "preferredHeightLowerBound")
            } else {
                UserDefaults.standard.removeObject(forKey: "preferredHeightLowerBound")
            }
        }
    }
    
    var preferredHeightUpperBound: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "preferredHeightUpperBound")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "preferredHeightUpperBound")
            } else {
                UserDefaults.standard.removeObject(forKey: "preferredHeightUpperBound")
            }
        }
    }
    
    var preferredMbti: String? {
        get {
            return UserDefaults.standard.string(forKey: "preferredMbti")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "preferredMbti")
            } else {
                UserDefaults.standard.removeObject(forKey: "preferredMbti")
            }
        }
    }
    func clearAll() {
        KeychainWrapper.standard.removeAllKeys()
    }
    
}

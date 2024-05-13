import Foundation
import SwiftKeychainWrapper

class SignDataManager {
    static let shared = SignDataManager()
    
    private init() {}
    var selectedImages: [UIImage] = []
    var profilePhotos: [Data]? {
        get {
            if let data = KeychainWrapper.standard.data(forKey: "profilePhotos") {
                // Keychain에서 데이터를 가져와서 배열로 변환하여 반환
                return [data]
            } else {
                return nil
            }
        }
        set {
            if let newValue = newValue, let firstPhotoData = newValue.first {
                // 배열이 새로운 값을 가지고 있고, 첫 번째 요소의 데이터를 Keychain에 저장
                KeychainWrapper.standard.set(firstPhotoData, forKey: "profilePhotos")
            } else {
                // 새로운 값이 nil이거나 배열이 비어 있을 경우 Keychain에서 데이터를 삭제
                KeychainWrapper.standard.removeObject(forKey: "profilePhotos")
            }
        }
    }
    var selfieImage : UIImage = UIImage()
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
            return KeychainWrapper.standard.string(forKey: "phoneNumber") // keychain 반환
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "phoneNumber") //keychain 저장
            } else {
                KeychainWrapper.standard.removeObject(forKey: "phoneNumber") //keychain 삭제
            }
        }
    }
    
    var birthDate: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "birthDate") // keychain 반환
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "birthDate") //keychain 저장
            } else {
                KeychainWrapper.standard.removeObject(forKey: "birthDate") //keychain 삭제
            }
        }
    }
    
    var nickName: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "nickName")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "nickName")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "nickName")
            }
        }
    }
    
    var gender: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "gender")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "gender")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "gender")
            }
        }
    }
    
    var height: Int? {
        get {
            return KeychainWrapper.standard.integer(forKey: "height")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "height")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "height")
            }
        }
    }
    
    var bodyType: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "bodyType")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "bodyType")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "bodyType")
            }
        }
    }
    
    var job: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "job")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "job")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "job")
            }
        }
    }
    
    var mbti: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "mbti")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "mbti")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "mbti")
            }
            
        }
    }
    
    var activityArea: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "activityArea")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "activityArea")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "activityArea")
            }
        }
    }
    
    var vocalRange: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "voaclRange")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "voaclRange")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "voaclRange")
            }
        }
    }
    
    var lookAlikeAnimal: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "lookAlikeAnimal")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "lookAlikeAnimal")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "lookAlikeAnimal")
            }
        }
    }
    
    var preferredAnimal:String? {
        get {
            return KeychainWrapper.standard.string(forKey: "preferredAnimal")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "preferredAnimal")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "preferredAnimal")
            }
        }
    }
    
    var preferredArea: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "preferredArea")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "preferredArea")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "preferredArea")
            }
        }
    }
    
    var preferredVocalRange: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "preferredVocalRange")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "preferredVocalRange")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "preferredVocalRange")
            }
        }
    }
    
    var preferredAgeLowerBound: Int? {
        get {
            return KeychainWrapper.standard.integer(forKey: "preferredAgeLowerBound")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "preferredAgeLowerBound")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "preferredAgeLowerBound")
            }
        }
    }
    
    var preferredAgeUpperBound: Int? {
        get {
            return KeychainWrapper.standard.integer(forKey: "preferredAgeUpperBound")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "preferredAgeUpperBound")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "preferredAgeUpperBound")
            }
        }
    }
    
    var preferredBodyType: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "preferredBodyType")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "preferredBodyType")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "preferredBodyType")
            }
        }
    }
    
    var preferredHeightLowerBound: Int? {
        get {
            return KeychainWrapper.standard.integer(forKey: "preferredHeightLowerBound")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "preferredHeightLowerBound")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "preferredHeightLowerBound")
            }
        }
    }
    
    var preferredHeightUpperBound: Int? {
        get {
            return KeychainWrapper.standard.integer(forKey: "preferredHeightUpperBound")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "preferredHeightUpperBound")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "preferredHeightUpperBound")
            }
        }
    }
    
    var preferredMbti: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "preferredMbti")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "preferredMbti")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "preferredMbti")
            }
        }
    }
    
}

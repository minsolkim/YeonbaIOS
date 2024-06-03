//
//  KeychainHandler.swift
//  YeonBa
//
//  Created by 김민솔 on 5/3/24.
//

import Foundation
import SwiftKeychainWrapper

struct KeychainHandler {
    static var shared = KeychainHandler()
    
    private let keychain = KeychainWrapper(serviceName: "YeonBa")
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"
    private let kakaoUserIDKey = "kakaoUserID"
    private let providerTokenKey = "providerToken"
    
    var accessToken: String {
        get {
            return KeychainWrapper.standard.string(forKey: accessTokenKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: accessTokenKey)
        }
    }
    
    var refreshToken: String {
        get {
            return KeychainWrapper.standard.string(forKey: refreshTokenKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: refreshTokenKey)
        }
    }
    
    var kakaoUserID: String {
        get {
            return KeychainWrapper.standard.string(forKey: kakaoUserIDKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: kakaoUserIDKey)
        }
    }
    
    var providerToken: String {
        get {
            return KeychainWrapper.standard.string(forKey: providerTokenKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: providerTokenKey)
        }
    }
    mutating func logout() {
        accessToken = ""
        refreshToken = ""
        KeychainWrapper.standard.removeObject(forKey: accessTokenKey)
        KeychainWrapper.standard.removeObject(forKey: refreshTokenKey)
    }
//    func clearTokens() {
//        keychain.remove(forKey: accessTokenKey)
//        keychain.remove(forKey: refreshTokenKey)
//        keychain.remove(forKey: kakaoUserIDKey)
//        keychain.remove(forKey: providerTokenKey)
//    }
}



//
//  Extension + UserDefaults.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 14.02.2022.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case userToken
        case userPhoneNumber
    }
    
    var token: String? {
        get {
            return string(forKey: UserDefaultsKeys.userToken.rawValue)
        } set {
            set(newValue, forKey: UserDefaultsKeys.userToken.rawValue)
        }
    }
    
    var userPhoneNumber: String? {
        get {
            return string(forKey: UserDefaultsKeys.userPhoneNumber.rawValue)
        } set {
            set(newValue, forKey: UserDefaultsKeys.userPhoneNumber.rawValue)
        }
    }

}

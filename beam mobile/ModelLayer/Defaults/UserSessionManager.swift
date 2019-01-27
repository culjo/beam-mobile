//
//  UserSessionManager.swift
//  trudata
//
//  Created by MAC on 1/24/19.
//  Copyright © 2019 trudata. All rights reserved.
//

import Foundation

struct UserSessionManger {
    
    static var accessToken: String {
        get {
            return UserDefaults.standard.string(forKey: "access_token") ?? ""
        }
        set (val){
            UserDefaults.standard.set(val, forKey: "access_token")
        }
    }
    static var userId: Int {
        get {
            return UserDefaults.standard.integer(forKey: "user_id")
        }
        set(val) {
            UserDefaults.standard.set(val, forKey: "user_id")
        }
    }
    
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: "name") ?? ""
        }
        set(val) {
            UserDefaults.standard.set(val, forKey: "name")
        }
    }
    
    static var phone: String {
        get {
            return UserDefaults.standard.string(forKey: "phone") ?? ""
        }
        set(val) {
            UserDefaults.standard.set(val, forKey: "phone")
        }
    }
    
    static var fcmToken: String {
        get {
            return UserDefaults.standard.string(forKey: "fcm_token") ?? ""
        }
        set(val) {
            UserDefaults.standard.set(val, forKey: "fcm_token")
        }
    }
    
    static var uuid: String {
        get {
            return UserDefaults.standard.string(forKey: "uuid") ?? ""
        }
        set(val) {
            UserDefaults.standard.set(val, forKey: "uuid")
        }
    }
    
    static var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "is_logged_in")
        }
        set(val) {
            return UserDefaults.standard.set(val, forKey: "is_logged_in")
        }
    }
    
    
}

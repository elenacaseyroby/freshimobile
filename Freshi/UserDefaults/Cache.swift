//
//  Auth.swift
//  Freshi
//
//  Created by Casey Roby on 6/3/21.
//
import SwiftUI

// Helpers
func userDefaultKeyExists(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

// Actual functions
func setAuthCredsInCache(authCreds: AuthCreds) {
//    print("set creds")
//    print("Start")
//    UserDefaults.standard.set(authCreds.code, forKey: "authCredsCode")
//    UserDefaults.standard.set(authCreds.userId, forKey: "authCredsUserId")
//    print("End")
    // Encode creds and save in user defaults cache
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(authCreds) {
        UserDefaults.standard.set(encoded, forKey: "AUTH_CREDS")
    }
}

func getAuthCredsFromCache() -> AuthCreds? {
//    if (
//        !userDefaultKeyExists(key: "authCredsCode") ||
//        !userDefaultKeyExists(key: "authCredsUserId")){
//        print("creds not set")
//        return nil
//    }
//    let code = UserDefaults.standard.string(forKey: "authCredsCode")
//    let userId = UserDefaults.standard.integer(forKey: "authCredsUserId")
//    print("creds set")
//    return AuthCreds(userId: userId, code: code!)
    // Get creds from user defaults cache and decode.
    if !userDefaultKeyExists(key: "AUTH_CREDS") {
        return nil
    }
    if let encodedAuthCreds = UserDefaults.standard.object(forKey: "AUTH_CREDS") as? Data {
        let decoder = JSONDecoder()
        if let authCreds = try? decoder.decode(AuthCreds.self, from: encodedAuthCreds) {
            return authCreds
        }
    }
    return nil
}

func clearAuthCredsFromCache() {
//    if userDefaultKeyExists(key: "authCredsCode") {
//        UserDefaults.standard.removeObject(forKey: "authCredsCode")
//    }
//    if userDefaultKeyExists(key: "authCredsUserId") {
//        UserDefaults.standard.removeObject(forKey: "authCredsUserId")
//    }
    
    UserDefaults.standard.removeObject(forKey: "AUTH_CREDS")
}

func clearAllDataFromUserDefaults() {
    let domain = Bundle.main.bundleIdentifier!
    UserDefaults.standard.removePersistentDomain(forName: domain)
    // To push the changes immediately, force update via the synchronize call.
    UserDefaults.standard.synchronize()
}

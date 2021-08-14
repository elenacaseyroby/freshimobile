//
//  AuthCredsCache.swift
//  Freshi
//
//  Created by Casey Roby on 8/13/21.
//

import SwiftUI

// AuthCreds functions
func setAuthCredsInCache(authCreds: AuthCredsModel) {
    // Encode creds and save in user defaults cache
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(authCreds) {
        UserDefaults.standard.set(encoded, forKey: "AUTH_CREDS")
    }
}

func getAuthCredsFromCache() -> AuthCredsModel? {
    // Get creds from user defaults cache and decode.
    if !userDefaultKeyExists(key: "AUTH_CREDS") {
        return nil
    }
    if let encodedAuthCreds = UserDefaults.standard.object(forKey: "AUTH_CREDS") as? Data {
        let decoder = JSONDecoder()
        if let authCreds = try? decoder.decode(AuthCredsModel.self, from: encodedAuthCreds) {
            return authCreds
        }
    }
    return nil
}

func clearAuthCredsFromCache() {
    UserDefaults.standard.removeObject(forKey: "AUTH_CREDS")
}

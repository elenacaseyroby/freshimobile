//
//  Cache.swift
//  Freshi
//
//  Created by Casey Roby on 6/3/21.
//
import SwiftUI

// Helpers
func userDefaultKeyExists(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

// General functions
func clearAllDataFromUserDefaults() {
    let domain = Bundle.main.bundleIdentifier!
    UserDefaults.standard.removePersistentDomain(forName: domain)
    // To push the changes immediately, force update via the synchronize call.
    UserDefaults.standard.synchronize()
}

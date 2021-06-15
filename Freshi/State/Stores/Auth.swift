//
//  LoginStore.swift
//  Freshi
//
//  Created by Casey Roby on 5/19/21.
//

import SwiftUI


// Must conform to ObservableObject protocol so that it can announce to subscribing views that it has changed.
class Auth: ObservableObject {
    // @Published tells the ObservableObject protocol which properties to publish changes for
    @Published var isloggedIn: Bool? = nil
    
    // initialize and set is logged in
    func checkIfLoggedIn() {
        // Check for auth token in cache and set auth.isLoggedIn accordingly.
        if getAuthCredsFromCache() != nil {
            self.isloggedIn = true
            return
        }
        self.isloggedIn = false
    }
    
    // Clear Auth to log out.
    func logOut() {
        // Set state to logged out.
        self.isloggedIn = false
        // Clear user defaults data
        clearAllDataFromUserDefaults()
    }
}

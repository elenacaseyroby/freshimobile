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
    @Published var creds: AuthCreds?
    
    // Clear Auth to log out.
    func logOut() {
        // Publish changes from main thread, not background thread.
        DispatchQueue.main.async {
            self.creds = nil
        }
        
    }
}

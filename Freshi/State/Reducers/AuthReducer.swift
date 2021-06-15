//
//  AuthReducer.swift
//  Freshi
//
//  Created by Casey Roby on 6/15/21.
//

import Foundation
import SwiftUI


struct AuthReducer {
    @EnvironmentObject var auth: Auth
    
    // Clear Auth to log out.
    func logIn(authCreds: AuthCreds) {
        // Send logged in state update back to the main thread with DispatchQueue to update UI.
        DispatchQueue.main.async {
            // Set state to logged in.
            self.auth.isloggedIn = true
        }
        // Set user auth creds in cache, so they persist.
        setAuthCredsInCache(authCreds: authCreds)
    }
    func reduce(action: ActionType, payload: Any) {
        // do nothing if the action type isn't applicable
        if action != ActionType.handleLogIn {
            return
        }
        // decode payload to AuthCred and pass to login
        let authCreds = Bundle.main.decode(AuthCreds.self, from: payload)
        // set state.
        self.logIn(authCreds: authCreds)
        
    }
}

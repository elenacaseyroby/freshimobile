//
//  AuthReducer.swift
//  Freshi
//
//  Created by Casey Roby on 6/15/21.
//

import Foundation
import SwiftUI


struct AuthReducer {
//    var state = AppState()
//    
//    init(state: AppState) {
//        self.state = state
//    }
    func logIn() {
        print("log in!")
    }
//    // Clear Auth to log out.
//    func logIn(authCreds: AuthCreds) {
//        // Send logged in state update back to the main thread with DispatchQueue to update UI.
//        DispatchQueue.main.async {
//            // Set state to logged in.
//            self.state.auth.isloggedIn = true
//        }
//        // Set user auth creds in cache, so they persist.
//        setAuthCredsInCache(authCreds: authCreds)
//    }
    func reduce(action: ActionType, payload: Data) {
        // do nothing if the action type isn't applicable
        if action != ActionType.handleLogIn {
            return
        }
        struct TokenResponse: Codable {
            var status_code: Int
            var detail: String?
            var user_id: Int?
            var token: String?
            
        }
        // decode payload to AuthCred and pass to login
        if let tokenReponse = try? JSONDecoder().decode(TokenResponse.self, from: payload) {
            let userId = tokenReponse.user_id!
            let code = tokenReponse.token!
            let authCreds = AuthCreds(userId: userId, code: code)
            // set state.
            self.logIn(authCreds: authCreds)
        }
    }
}

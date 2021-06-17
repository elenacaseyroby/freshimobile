//
//  loginHandler.swift
//  Freshi
//
//  Created by Casey Roby on 6/15/21.
//

import Foundation

private func logIn(authStore: AuthStore, authCreds: AuthCredsModel) {
    // Set user auth creds in cache, so they persist.
    setAuthCredsInCache(authCreds: authCreds)
    // pass payload and action to root reducer
    DispatchQueue.main.async {
        authStore.isloggedIn = true
    }
}

// Updates Auth state
func logInAction(
    username: String,
    password: String,
    authStore: AuthStore,
    onSuccess: @escaping () -> Void,
    onError: @escaping (RequestError?) -> Void,
    onComplete: @escaping () -> Void){
    let headers: [String: String] = [
        "username": username,
        "password": password,
    ]
    struct TokenResponse: Codable {
        var status_code: Int
        var detail: String?
        var user_id: Int?
        var token: String?
        
    }
    FreshiRequest(
        endpoint: "token/",
        method: "POST",
        headers: headers,
        onComplete: {(data, requestError) in
            if let data = data {
                if let tokenReponse = try? JSONDecoder().decode(TokenResponse.self, from: data) {
                    // if request succeeded and error, return error
                    if var error = requestError {
                        // Add additional info from error message
                        error.errorMessage = tokenReponse.detail!
                        // Return error to View
                        onError(error)
                    // if request succeeded and no error, log in.
                    } else {
                            let userId = tokenReponse.user_id!
                            let token = tokenReponse.token!
                        let authCreds = AuthCredsModel(userId: userId, token: token)
                            // Update state
                            logIn(authStore: authStore, authCreds: authCreds)
                            onSuccess()
                        }
                    }
            // if request failed, return error.
            } else if let requestError = requestError {
                // Return error to View
                onError(requestError)
            }
            onComplete()
        })
}

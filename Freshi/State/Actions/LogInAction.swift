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
        authStore.isLoggedIn = true
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
    struct TokenErrorResponse: Codable {
        var detail: String?
    }
    FreshiRequest(
        endpoint: "token/",
        method: "POST",
        headers: headers,
        onComplete: {(data, requestError) in
            // If request failed, get any extra info and return RequestError.
            if let requestError = requestError {
                // Return error to View
                // If error check for error detail.
                var errorMessage: String?
                if let data = data {
                    if let errorResponse = try? JSONDecoder().decode(TokenErrorResponse.self, from: data) {
                        errorMessage = errorResponse.detail
                    }
                }
                onError(RequestError(
                    statusCode: requestError.statusCode,
                    errorMessage: errorMessage == nil ? requestError.errorMessage : errorMessage
                ))
            }
            // If request succeeded, return data.
            else if let data = data {
                if let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: data) {
                    let userId = tokenResponse.user_id!
                    let token = tokenResponse.token!
                    let authCreds = AuthCredsModel(userId: userId, token: token)
                    // Update state
                    logIn(authStore: authStore, authCreds: authCreds)
                    onSuccess()
                }
            }
            onComplete()
        })
}

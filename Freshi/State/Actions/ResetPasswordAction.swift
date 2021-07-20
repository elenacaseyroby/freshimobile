//
//  PasswordReset.swift
//  Freshi
//
//  Created by Casey Roby on 7/20/21.
//

import Foundation


// Update password and log in user.
func resetPasswordAction(
    password: String,
    authToken: String,
    authStore: AuthStore,
    onSuccess: @escaping () -> Void,
    onError: @escaping (RequestError) -> Void,
    onComplete: @escaping () -> Void) {
    let headers: [String: String] = [
        "password": password,
        "Authorization": authToken,
    ]
    struct PasswordResetError: Codable {
        var detail: String?
    }
    struct PasswordResetSuccess: Codable {
        var detail: String?
        var user_id: Int?
        var token: String?
    }
    FreshiRequest(
        endpoint: "password-reset/",
        method: "POST",
        headers: headers,
        onComplete: {(data, requestError) in
            if var requestError = requestError {
                // Get extra info on error if not server side error.
                if let data = data {
                    if let error = try? JSONDecoder().decode(PasswordResetError.self, from: data) {
                        requestError.errorMessage = error.detail
                    }
                }
                // If request failed return error.
                onError(requestError)
            }
            else {
                // If success, log user in by setting auth creds in cache and updating authStore.isLoggedIn state.
                if let data = data {
                    if let response = try? JSONDecoder().decode(PasswordResetSuccess.self, from: data) {
                        let authCreds = AuthCredsModel(userId: response.user_id!, token: response.token!)
                        // Update state
                        setAuthCreds(authStore: authStore, authCreds: authCreds)
                        onSuccess()
                    }
                }
            }
            onComplete()})
}


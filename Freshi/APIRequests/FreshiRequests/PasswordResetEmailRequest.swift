//
//  PasswordResetEmail.swift
//  Freshi
//
//  Created by Casey Roby on 7/16/21.
//

import Foundation

// Doesn't update state
func passwordResetEmailRequest(
    email: String,
    onSuccess: @escaping () -> Void,
    onError: @escaping (RequestError) -> Void,
    onComplete: @escaping () -> Void) {
    let headers: [String: String] = [
        "email": email,
    ]
    struct PasswordResetEmailError: Codable {
        var detail: String?
    }
    FreshiRequest(
        endpoint: "password-reset-email/",
        method: "POST",
        headers: headers,
        onComplete: {(data, requestError) in
            if var requestError = requestError {
                // Get extra info on error if not server side error.
                if let data = data {
                    if let error = try? JSONDecoder().decode(PasswordResetEmailError.self, from: data) {
                        requestError.errorMessage = error.detail
                    }
                }
                // If request failed return error.
                onError(requestError)
            }
            else {
                onSuccess()
            }
            onComplete()})
}


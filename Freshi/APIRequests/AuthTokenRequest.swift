//
//  AuthCreditsRequest.swift
//  Freshi
//
//  Created by Casey Roby on 5/19/21.
//

import Foundation
import SwiftUI


// fetch, update, add, delete
func fetchAuthTokenRequest(
    username: String,
    password: String,
    completionHandler: @escaping (Data?, RequestError?) -> Void) {
    let headers: [String: String] = [
        "username": username,
        "password": password,
    ]
    
    APIRequest(
        endpoint: "token/",
        method: "POST",
        headers: headers,
        onComplete: {(data, response, error) in
            // Define return type.
            struct TokenResponse: Codable {
                var status_code: Int
                var detail: String?
                var user_id: Int?
                var token: String?
                
            }
            // Return data.
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(TokenResponse.self, from: data) {
                    // Check for auth credentials.
                    let statusCode: Int = decodedResponse.status_code
                    if statusCode == 200 {
//                        // If status code is 200, our api will always return user_id and token, so we know we can safely unwrap.
//                        let userId = decodedResponse.user_id!
//                        let code = decodedResponse.token!
//                        let authCredentials = AuthCreds(userId: userId, code: code)
                        completionHandler(data, nil)
                        return
                    }
                    // Return error detail.
                    let errorMessage = decodedResponse.detail!
                    let requestError = RequestError(statusCode: statusCode, errorMessage: errorMessage)
                    completionHandler(nil, requestError)
                    return
                }
            }
            // Return error if request failed altogether.
            var errorMessage: String?
            var statusCode = 500
            if let error = error {
                errorMessage = error.localizedDescription
            }
            // Set response statusCode even if data isn't returned.
            if let response = response {
                // Force response to be type HTTPURLResponse to access statusCode.
                let httpResponse = response as! HTTPURLResponse
                statusCode = httpResponse.statusCode
            }
            let requestError = RequestError(statusCode: statusCode, errorMessage: errorMessage)
            completionHandler(nil, requestError)
        })
}

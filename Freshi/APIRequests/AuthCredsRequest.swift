//
//  AuthAPI.swift
//  Freshi
//
//  Created by Casey Roby on 5/19/21.
//

import Foundation
import SwiftUI


struct RequestError: Codable {
    var statusCode: Int
    var errorMessage: String?
}

// fetch, update, add, delete
func fetchAuthCreds(
    username: String,
    password: String,
    completionHandler: @escaping (AuthCreds?, RequestError?) -> Void)
{
    // set up request
    // TODO: Change this url before deploy
    let baseURL = URL(string: "http://localhost:8000/api/v1/")!
    let url = baseURL.appendingPathComponent("token/")
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.setValue(username, forHTTPHeaderField: "username")
    request.setValue(password, forHTTPHeaderField: "password")

    // this is an example of a function being called with a completion handler:
    
    // URLSession automatically runs in the background thread – an independent piece of code that’s running at the same time as the rest of our program. This means the network request can be running without stopping our UI from being interactive.
    URLSession.shared.dataTask(with: request) {(data, response, error) in
        // Define return type.
        struct TokenResponse: Codable {
            var status_code: Int
            var detail: String?
            var user_id: Int?
            var token: String?
            
        }
        if let data = data {
            if let decodedResponse = try? JSONDecoder().decode(TokenResponse.self, from: data) {
                // Check for auth credentials.
                let statusCode: Int = decodedResponse.status_code
                if statusCode == 200 {
                    // If status code is 200, our api will always return user_id and token, so we know we can safely unwrap.
                    let userId = decodedResponse.user_id!
                    let code = decodedResponse.token!
                    let authCredentials = AuthCreds(userId: userId, code: code)
                    completionHandler(authCredentials, nil)
                    return
                }
                let errorMessage = decodedResponse.detail!
                let requestError = RequestError(statusCode: statusCode, errorMessage: errorMessage)
                completionHandler(nil, requestError)
                return
            }
        }
        
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
    // Without resume() the request does nothing and you’ll be staring at a blank screen. But with it the request starts immediately, it will automatically run in the background, and won’t be destroyed even after our method ends.
    }.resume()
}

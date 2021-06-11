//
//  UserRequest.swift
//  Freshi
//
//  Created by Casey Roby on 6/11/21.
//

import Foundation
import SwiftUI

struct UserRequestError: Codable {
    var status_code: Int?
    var error_message: String?
    var error_field: String?
}

// fetch, update, create, delete
func createUserRequest(
    username: String,
    email: String,
    password: String,
    completionHandler: @escaping (User?, UserRequestError?) -> Void)
{
    let body: [String: String] = [
        "username": username,
        "email": email,
        "password": password,
    ]
    APIRequest(
        endpoint: "users/new/",
        method: "POST",
        body: body,
        onComplete: {(data, response, error) in
            var statusCode = 500
            // Set response statusCode even if data isn't returned.
            if let response = response {
                // Force response to be type HTTPURLResponse to access statusCode.
                let httpResponse = response as! HTTPURLResponse
                statusCode = httpResponse.statusCode
            }
            if statusCode != 200 {
                if let data = data {
                    if let error = try? JSONDecoder().decode(UserRequestError.self, from: data) {
                        completionHandler(nil, error)
                        return
                    }
                }
            }
            if let data = data {
                print(data)
                if let user = try? JSONDecoder().decode(User.self, from: data) {
                    completionHandler(user, nil)
                    return
                }
            }
            var errorMessage: String?
            if let error = error {
                errorMessage = error.localizedDescription
            }
            let error = UserRequestError(status_code: statusCode, error_message: errorMessage)
            completionHandler(nil, error)
            return
        })
}


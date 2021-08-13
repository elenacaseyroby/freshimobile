//
//  CreateUser.swift
//  Freshi
//
//  Created by Casey Roby on 6/16/21.
//

import Foundation


struct CreateUserError: Codable {
    var status_code: Int?
    var errorMessage: String?
    // errors is a dictionary in this format:
    // errorField: errorMessage
    var fieldErrors: [String: [String]]?
}

// Doesn't update state
func createUserAction(
    username: String,
    email: String,
    password: String,
    onSuccess: @escaping (UserModel) -> Void,
    onError: @escaping (CreateUserError) -> Void,
    onComplete: @escaping () -> Void) {
    let body: [String: String] = [
        "username": username,
        "email": email,
        "password": password,
    ]
    struct UserResponse: Identifiable, Codable, Equatable {
        var id: Int
        var username: String
        var email: String
        var first_name: String?
        var last_name: String?
    }
    FreshiRequest(
        endpoint: "users/new/",
        method: "POST",
        body: body,
        onComplete: {(data, requestError) in
            if let requestError = requestError {
                var createUserError = CreateUserError(
                    status_code: requestError.statusCode,
                    errorMessage: requestError.errorMessage
                )
                // gather error details.
                if let data = data {
                    if let errors = try? JSONDecoder().decode([String: [String]].self, from: data) {
                        createUserError.fieldErrors = errors
                    }
                }
                // If request failed return error.
                onError(createUserError)
            }
            else if let data = data {
                if let userResponse = try? JSONDecoder().decode(UserResponse.self, from: data) {
                    let user = UserModel(
                        id: userResponse.id,
                        username: userResponse.username,
                        email: userResponse.email,
                        first_name: userResponse.first_name,
                        last_name: userResponse.last_name
                    )
                    onSuccess(user)
                }
            }
            onComplete()})
}

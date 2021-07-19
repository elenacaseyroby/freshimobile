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
    FreshiRequest(
        endpoint: "users/new/",
        method: "POST",
        body: body,
        onComplete: {(data, requestError) in
            if let requestError = requestError {
                print("REQUEST ERROR")
                print(requestError)
                var createUserError = CreateUserError(
                    status_code: requestError.statusCode,
                    errorMessage: requestError.errorMessage
                )
                print(createUserError)
                // gather error details.
                if let data = data {
                    if let errors = try? JSONDecoder().decode([String: [String]].self, from: data) {
                        print("MADE IT")
                        print(errors)
                        createUserError.fieldErrors = errors
                    }
                }
                // If request failed return error.
                onError(createUserError)
            }
            else if let data = data {
                if let user = try? JSONDecoder().decode(UserModel.self, from: data) {
                    onSuccess(user)
                }
            }
            onComplete()})
}

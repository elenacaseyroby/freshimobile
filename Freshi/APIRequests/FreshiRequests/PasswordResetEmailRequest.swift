//
//  PasswordResetEmail.swift
//  Freshi
//
//  Created by Casey Roby on 7/16/21.
//

//import Foundation
//
//
//struct PasswordResetEmailError: Codable {
//    var status_code: Int?
//    var error_message: String?
//    var error_field: String?
//}
//
//// Doesn't update state
//func PasswordResetEmailRequest(
//    username: String,
//    email: String,
//    password: String,
//    onSuccess: @escaping (UserModel) -> Void,
//    onError: @escaping (CreateUserError) -> Void,
//    onComplete: @escaping () -> Void) {
//    let body: [String: String] = [
//        "username": username,
//        "email": email,
//        "password": password,
//    ]
//    FreshiRequest(
//        endpoint: "users/new/",
//        method: "POST",
//        body: body,
//        onComplete: {(data, requestError) in
//            if let data = data {
//                    // if request succeeded and error, gather error details.
//                    if let requestError = requestError {
//                        if var error = try? JSONDecoder().decode(CreateUserError.self, from: data) {
//                            error.status_code = requestError.statusCode
//                            onError(error)
//                        }
//                    }
//                    // if request succeeded and no error, return user.
//                    else {
//                        if let user = try? JSONDecoder().decode(UserModel.self, from: data) {
//                            onSuccess(user)
//                        }
//                    }
//            } else if let requestError = requestError {
//                let error = CreateUserError(
//                    status_code: requestError.statusCode,
//                    error_message: requestError.errorMessage)
//                // If request failed return error.
//                onError(error)
//            }
//            onComplete()})
//}


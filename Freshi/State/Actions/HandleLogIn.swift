//
//  loginHandler.swift
//  Freshi
//
//  Created by Casey Roby on 6/15/21.
//

import Foundation


func handleLogIn(
    username: String,
    password: String,
    onError: @escaping (RequestError?) -> Void,
    onComplete: @escaping () -> Void){
    fetchAuthTokenRequest(username: username, password: password, completionHandler: { data, requestError in
        // on success pass data back to rootReducer
        if let data = data {
            // pass payload and action to root reducer
            rootReducer(action: ActionType.handleLogIn, payload: data)
        }
        // on error pass error back to view
        if let requestError = requestError {
            onError(requestError)
        }
        onComplete()
    })
}

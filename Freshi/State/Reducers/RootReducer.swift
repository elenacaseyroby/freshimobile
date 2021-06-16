//
//  rootReducer.swift
//  Freshi
//
//  Created by Casey Roby on 6/15/21.
//

import Foundation

//struct AppState {
//    var auth: Auth?
//}

// TODO: make payload keep json data structure so that it can be decoded once it lands in the correct reducer
struct RootReducer {
    // A singleton for our entire app to use
    static let shared = RootReducer()

//    var state: AppState = AppState()
//
//    // init runs everytime the auth state changes.
//    init(auth: Auth) {
//        self.state.auth = auth
//    }
    func reduce(action: ActionType, payload: Data) {
        // pass through to all reducers so that they can update state if need be
        AuthReducer().reduce(action: action, payload: payload)
    }
}

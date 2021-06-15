//
//  rootReducer.swift
//  Freshi
//
//  Created by Casey Roby on 6/15/21.
//

import Foundation

// TODO: make payload keep json data structure so that it can be decoded once it lands in the correct reducer
func rootReducer(action: ActionType, payload: Any) {
    // pass through to all reducers so that they can update state if need be
    AuthReducer().reduce(action: action, payload: payload)
}

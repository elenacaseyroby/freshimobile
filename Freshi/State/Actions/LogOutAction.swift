//
//  HandleLogOut.swift
//  Freshi
//
//  Created by Casey Roby on 6/16/21.
//

// Updates Auth state
func logOutAction(auth: Auth){
    // Set state to logged out.
    auth.isloggedIn = false
    // Clear user defaults data
    clearAllDataFromUserDefaults()
}


//
//  HandleLogOut.swift
//  Freshi
//
//  Created by Casey Roby on 6/16/21.
//

// Updates Auth state
func logOutAction(authStore: AuthStore){
    // Set state to logged out.
    authStore.isloggedIn = false
    // Clear user defaults data
    clearAllDataFromUserDefaults()
}


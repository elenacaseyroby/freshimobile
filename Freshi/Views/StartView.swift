//
//  StartView.swift
//  Freshi
//
//  Created by Casey Roby on 5/31/21.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var auth: Auth
    
    // init runs everytime the auth state changes.
    init(auth: Auth) {
        // if isloggedIn state hasn't been set, check if log in credentials are stored in user defaults cache.
        if auth.isloggedIn == nil {
            auth.checkIfLoggedIn()
        }
    }
    
    var body: some View {
        // If creds in state, show logged in view.
        if auth.isloggedIn! {
            LoggedInView()
        // If no creds, show logged out view.
        } else {
            Landing()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        let auth: Auth = Auth()
        StartView(auth: auth)
    }
}



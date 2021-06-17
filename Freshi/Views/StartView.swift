//
//  StartView.swift
//  Freshi
//
//  Created by Casey Roby on 5/31/21.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var auth: Auth
    @EnvironmentObject var loader: Loader
    @EnvironmentObject var onboarding: Onboarding
    
    // init runs everytime the auth state changes.
    init(auth: Auth) {
        // if isloggedIn state hasn't been set, check if log in credentials are stored in user defaults cache.
        if auth.isloggedIn == nil {
            // Check for auth token in cache and set auth.isLoggedIn accordingly.
            if getAuthCredsFromCache() != nil {
                auth.isloggedIn = true
                return
            }
            auth.isloggedIn = false
        }
        // TODO: there will be a time when users have auth creds but they are expired.
        // how should we deal with them?  What does it look like when a request is made
        // to an endpoint using an expired auth token?
    }
    
    var body: some View {
        VStack {
            if onboarding.showSignUpCompletedScreen {
                // If no creds, show logged out view.
                SignUpComplete()
            } else if auth.isloggedIn! {
                // If creds in state, show logged in view.
                LoggedInView()
            } else {
                // if logged out, show logged out landing.
                Landing()
            }
        }
        .overlay(
            LoadingOverlay(animation:LoaderAnimation.bubbles, isLoading: self.loader.showLoadingOverlay)
         )
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        let auth: Auth = Auth()
        StartView(auth: auth)
    }
}

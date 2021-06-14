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
            auth.checkIfLoggedIn()
        }
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

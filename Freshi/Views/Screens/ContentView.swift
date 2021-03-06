//
//  StartView.swift
//  Freshi
//
//  Created by Casey Roby on 5/31/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var privacyPolicyStore: PrivacyPolicyStore
    @EnvironmentObject var termsStore: TermsStore
    @EnvironmentObject var authStore: AuthStore
    // Manages overlays and screen redirects.
    @EnvironmentObject var screenManagerStore: ScreenManagerStore
    
    // init runs everytime the auth state changes.
    init(authStore: AuthStore) {
        self.checkIfLoggedIn(authStore: authStore)
        // TODO: there will be a time when users have auth creds but they are expired.
        // how should we deal with them?  What does it look like when a request is made
        // to an endpoint using an expired auth token?
    }
    
    func checkIfLoggedIn(authStore: AuthStore) {
        // if isloggedIn state hasn't been set, check if log in credentials are stored in user defaults cache.
        if authStore.isLoggedIn == nil {
            // Check for auth token in cache and set auth.isLoggedIn accordingly.
            if getAuthCredsFromCache() != nil {
                authStore.isLoggedIn = true
                return
            }
            authStore.isLoggedIn = false
        }
    }
    
    func showLoggedInLanding() -> Bool {
        if self.authStore.isLoggedIn == nil {
            return false
        }
        return self.authStore.isLoggedIn!
    }
    
    var body: some View {
        VStack {
            if showLoggedInLanding() {
                // If creds in state, show logged in view.
                LoggedInMain()
            } else {
                // if logged out, show logged out landing.
                LoggedOutMain()
            }
        }
        .overlay(
            LoadingOverlay(animation:LoaderAnimation.bubbles, isLoading: self.screenManagerStore.showLoadingOverlay)
         )
        .onAppear() {
            // Load the following pieces of state on app load:
            // privacy policy
            getPrivacyPolicyAction(
                privacyPolicyStore: privacyPolicyStore,
                onSuccess: {},
                onError: { requestError in },
                onComplete: {}
            )
            getTermsAction(
                termsStore: termsStore,
                onSuccess: {},
                onError: { requestError in },
                onComplete: {}
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let authStore: AuthStore = AuthStore()
        ContentView(authStore: authStore)
    }
}

//
//  FreshiApp.swift
//  Freshi
//
//  Created by Casey Roby on 5/19/21.
//

import SwiftUI

// @main specifies that this is the starting point of our app.
@main
struct FreshiApp: App {
    @StateObject var privacyPolicyStore = PrivacyPolicyStore()
    @StateObject var termsStore = TermsStore()
    @StateObject var authStore = AuthStore()
    // Manages overlays and screen redirects.
    @StateObject var screenManagerStore = ScreenManagerStore()
    // we need some way to pass state into the root reducer so that it can manage state
    // without updating every view every time any single piece of state is updated.
    
    var body: some Scene {
        WindowGroup {
            ContentView(authStore: authStore)
                // pass our order state into our Main view.
                .environmentObject(authStore)
                .environmentObject(screenManagerStore)
                .environmentObject(privacyPolicyStore)
                .environmentObject(termsStore)
                // test dark mode:
//                .preferredColorScheme(.dark)
                
        }
    }
}


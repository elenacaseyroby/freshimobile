//
//  FreshiApp.swift
//  Freshi
//
//  Created by Casey Roby on 5/19/21.
//

import SwiftUI

@main
struct FreshiApp: App {
    @StateObject var authStore = AuthStore()
    @StateObject var loader = Loader()
    @StateObject var onboarding = Onboarding()
    
    // we need some way to pass state into the root reducer so that it can manage state
    // without updating every view every time any single piece of state is updated.
    
    var body: some Scene {
        WindowGroup {
            ContentView(authStore: authStore)
                // pass our order state into our Main view.
                .environmentObject(authStore)
                .environmentObject(loader)
                .environmentObject(onboarding)
                // test dark mode:
//                .preferredColorScheme(.dark)
                
        }
    }
}


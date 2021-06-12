//
//  FreshiApp.swift
//  Freshi
//
//  Created by Casey Roby on 5/19/21.
//

import SwiftUI

@main
struct FreshiApp: App {
    @StateObject var auth = Auth()
    @StateObject var loader = Loader()
    @StateObject var onboarding = Onboarding()
    
    var body: some Scene {
        WindowGroup {
            StartView(auth: auth)
                // pass our order state into our Main view.
                .environmentObject(auth)
                .environmentObject(loader)
                .environmentObject(onboarding)
                // test dark mode:
//                .preferredColorScheme(.dark)
                
        }
    }
}


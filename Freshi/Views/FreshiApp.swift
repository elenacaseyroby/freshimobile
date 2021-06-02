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
    
    var body: some Scene {
        WindowGroup {
            StartView()
                // pass our order state into our Main view.
                .environmentObject(auth)
                // test dark mode:
//                .preferredColorScheme(.dark)
        }
    }
}

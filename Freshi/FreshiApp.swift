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
            ContentView()
                // pass our order state into our Main view.
                .environmentObject(auth)
                .font(.system(.title2, design: .rounded))
        }
    }
}

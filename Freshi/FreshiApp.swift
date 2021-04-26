//
//  FreshiApp.swift
//  Freshi
//
//  Created by Casey Roby on 4/26/21.
//

import SwiftUI

@main
struct FreshiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

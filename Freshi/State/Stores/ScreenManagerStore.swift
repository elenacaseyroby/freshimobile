//
//  ScreenManagerStore.swift
//  Freshi
//
//  Created by Casey Roby on 6/17/21.
//

import SwiftUI


// Manages overlays and screen redirects.
class ScreenManagerStore: ObservableObject {
    // @Published tells the ObservableObject protocol which properties to publish changes for
    @Published var showSignUpCompletedScreen: Bool = false
    @Published var showLoadingOverlay: Bool = false
}

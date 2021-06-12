//
//  Onboarding.swift
//  Freshi
//
//  Created by Casey Roby on 6/11/21.
//

import SwiftUI


// Must conform to ObservableObject protocol so that it can announce to subscribing views that it has changed.
class Onboarding: ObservableObject {
    // @Published tells the ObservableObject protocol which properties to publish changes for
    @Published var showCompletedScreen: Bool = false
}

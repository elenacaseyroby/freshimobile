//
//  PrivacyPolicyStore.swift
//  Freshi
//
//  Created by Casey Roby on 8/13/21.
//

import SwiftUI


// Must conform to ObservableObject protocol so that it can announce to subscribing views that it has changed.
class PrivacyPolicyStore: ObservableObject {
    // @Published tells the ObservableObject protocol which properties to publish changes for
    @Published var body: String = ""
    // default is Date() which is today
    @Published var datePublished: Date = Date()
}

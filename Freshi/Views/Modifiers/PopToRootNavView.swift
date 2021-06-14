//
//  PopToRootNavigation.swift
//  Freshi
//
//  Created by Casey Roby on 6/9/21.
//

import Foundation
import SwiftUI

// pops back to root one view at a time
struct PopToRootNavView: ViewModifier {
    // Have to bind the state to the parent view so the onChange recognizes the state change.
    @Binding var navToRoot: Bool
    // State used to pop back one view
    @Environment(\.presentationMode) var presentationMode
    
    func popToLastViewInNavStack() {
        self.presentationMode.wrappedValue.dismiss()
    }
 
    func body(content: Content) -> some View {
        content
            // Pop to last view if navToRoot is true
            .onAppear() {
                if (self.navToRoot) {
                    self.popToLastViewInNavStack()
                }
            }
            .onChange(of: navToRoot) { newValue in
                if (newValue) {
                    print("called pop")
                    self.popToLastViewInNavStack()
                }
            }
    }
}

// The extension allows us to use the modifier like this:
// .fontStyle()
// instead of like this:
// .modifier(FontStyle())
extension View {
    func popToRootNavView(navToRoot: Binding<Bool>) -> some View {
        self.modifier(PopToRootNavView(navToRoot: navToRoot))
    }
}

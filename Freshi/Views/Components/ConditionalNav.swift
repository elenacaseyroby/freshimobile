//
//  ConditionalNavButton.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import Foundation
import SwiftUI

// Navigates to destination if navigateToDestination is set to true.
struct ConditionalNav<Content: View>: View {
    var navigateToDestination: Bool
    // args
    var destination: Content
    
    init(
        navigateToDestination: Bool,
        @ViewBuilder destination: () -> Content) {
        self.navigateToDestination = navigateToDestination
        self.destination = destination()
    }

    // state
    // triggers navigation link to destination view when set to "destination".
    @State var selection: String? = nil
    
    var body: some View {
        HStack {
            // only navigate if navigateToDestination is set to true.
            if self.navigateToDestination  {
                NavigationLink(
                    destination:
                        self.destination
                        .transition(.move(edge: .bottom))
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    tag: "destination",
                    selection: $selection){
                        EmptyView()
                    }
                .onAppear() {
                    self.selection = "destination"
                }
            }
        }
    }
}
// strictly for dev previews in xcode.
struct ConditionalNav_Previews: PreviewProvider {
    static var previews: some View {
        ConditionalNav(navigateToDestination: true) {
            LogIn(selection: .constant("log-in"))
        }
    }
}

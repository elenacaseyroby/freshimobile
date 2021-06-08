//
//  NavButton.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import Foundation
import SwiftUI

struct NavButton<Content: View>: View {
    // args
    var label: String
    // controls color of button
    var state: StretchyButtonState = StretchyButtonState.focused
    var destination: Content
    
    init(
        label: String,
        state: StretchyButtonState,
        @ViewBuilder destination: () -> Content) {
        self.label = label
        self.state = state
        self.destination = destination()
    }

    // state
    @State var selection: String? = nil
    
    var body: some View {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                // Conditionally render Nav Link to fix "Unable to present. Please file a bug." error.
                if selection == "destination" {
                    // Set navigation destination as LogIn view
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
                }
                // Set up button to trigger navigation link to LogIn view destination.
                Button(self.label){
                    self.selection = "destination"
                }
                .stretchyButton(state: self.state)
            }
    }
}
// strictly for dev previews in xcode.
struct NavButton_Previews: PreviewProvider {
    static var previews: some View {
        NavButton(label: "Log in", state: StretchyButtonState.focused) {
            LogIn()
        }
    }
}


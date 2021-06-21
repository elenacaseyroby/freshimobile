//
//  LandingView.swift
//  Freshi
//
//  Created by Casey Roby on 4/21/21.
//

import SwiftUI


struct Landing: View {
    @Binding var selection: String
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 0){
                // Header and Image
                LandingHeader()
                .navigationBarHidden(true)
                StretchyImage(imageName: "landing-collage")
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 15) {
                    Button("Log in") {
                        self.selection = "log-in"
                    }
                        .stretchyButton(state: StretchyButtonState.neutral)
                    Button("Create an account") {
                        self.selection = "sign-up"
                    }
                        .stretchyButton(state: StretchyButtonState.focused)
                    // Links
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
                        Button("Terms & Conditions") {
                            self.selection = "t&c"
                        }
                        .fontStyle(fontStyle: .subheadline)
                        .foregroundColor(Color("interactiveFocus"))
                        Image("dot")
                        Button("Reset Password") {
                            self.selection = "reset-password"
                        }
                        .fontStyle(fontStyle: .subheadline)
                        .foregroundColor(Color("interactiveFocus"))
                    }
                    Text("© freshi 2021")
                    .fontStyle(fontStyle: .caption)
                    .foregroundColor(Color("highContrast"))
                    .padding(.bottom, 5)
                }
            }
            .padding(.horizontal, GlobalStyles.padding)
            .background(Color("background"))
        }
        .navigationBarHidden(true)
        // Fixes nav error: “displayModeButtonItem is internally managed and not exposed for DoubleColumn style. Returning an empty, disconnected UIBarButtonItem to fulfill the non-null contract.”
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
// strictly for dev previews in xcode.
struct Landing_Previews: PreviewProvider {
    static var previews: some View {
        Landing(selection: .constant("log-in"))
    }
}

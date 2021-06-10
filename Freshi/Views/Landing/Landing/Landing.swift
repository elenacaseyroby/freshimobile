//
//  LandingView.swift
//  Freshi
//
//  Created by Casey Roby on 4/21/21.
//

import SwiftUI


struct Landing: View {
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 0){
                // Header and Image
                LandingHeader()
                .navigationBarHidden(true)
                StretchyImage(imageName: "landing-collage")
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 15) {
                    NavButton(label: "Log in", state: StretchyButtonState.neutral) {
                        LogIn()
                    }
                    NavButton(label: "Create an account", state: StretchyButtonState.focused) {
                        SignUp()
                    }
                    // Links
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
                        NavLink(label: "Privacy", color: Color("info")) {
                            PrivacyPolicy()
                        }
                        Text("&")
                            .fontStyle(fontStyle: .callout)
                            .foregroundColor(Color("highContrast"))
                        NavLink(label: "Terms", color: Color("info")) {
                            TermsAndConditions()
                        }
                        Image("dot")
                        NavLink(label: "Reset Password", color: Color("interactiveFocus")) {
                            RequestPasswordReset()
                        }
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
        Landing()
    }
}

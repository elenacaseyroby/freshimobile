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
            VStack(alignment: .center, spacing: 20){
                Spacer(minLength: 10)
                LandingHeader()
                .navigationBarHidden(true)
                StretchyImage(imageName: "landing-collage")
                    .padding(.bottom, 0)
                NavButton(label: "Log in", state: StretchyButtonState.focused) {
                    LogIn()
                }
                NavButton(label: "Create an account", state: StretchyButtonState.neutral) {
                    SignUp()
                }
                // Links
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
                    PrivacyNavLink()
                    Text("&")
                        .fontStyle(fontStyle: .callout)
                        .foregroundColor(Color("highContrast"))
                    TermsNavLink()
                    Image("dot")
                    ResetPWNavLink(label: "Reset Password")
                }
                Text("© freshi 2021")
                .fontStyle(fontStyle: .caption)
                .foregroundColor(Color("highContrast"))
                .padding(.vertical, 5)
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

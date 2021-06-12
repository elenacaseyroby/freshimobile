//
//  SignUpComplete.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import SwiftUI

struct SignUpComplete: View {
    // use to send to completion page
    @EnvironmentObject var onboarding: Onboarding
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(
                    title: "Success!",
                    onExit: {
                        self.onboarding.showCompletedScreen = false
                    })
                // Show progress from last page to current page.
                ProgressBar(
                    fromPercent: CGFloat(
                        percentAsDecimal(value: 3, total: 4)),
                    toPercent: CGFloat(1.0)
                )
            }
            VStack {
                // Labels
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("You’ve created a new account")
                            .foregroundColor(Color("highContrast"))
                            .fontStyle(fontStyle: .headline)
                        Text("Take a moment to finish setting up your profile")
                            .foregroundColor(Color("highContrast"))
                            .fontStyle(fontStyle: .subheadline)
                    }
                    Spacer()
                }
                // Image
                StretchyImage(imageName: "landing-collage")
                // Buttons
                VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 15) {
                    // Back Button
                    Button("Skip") {
                        self.onboarding.showCompletedScreen = false
                    }
                        .stretchyButton(
                            state: StretchyButtonState.neutral)
                    // Next Button & Nav
                    Button("Continue") {
                        print("direct to onboarding pages")
                    }
                        .stretchyButton(
                            state: StretchyButtonState.focused)
                }
            }
        }
        .padding(.horizontal, GlobalStyles.padding)
        .padding(.bottom, GlobalStyles.padding)
    }
}

struct SignUpComplete_Previews: PreviewProvider {
    static var previews: some View {
        SignUpComplete()
    }
}


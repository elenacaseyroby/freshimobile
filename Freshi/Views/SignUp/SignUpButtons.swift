//
//  SignUpButtons.swift
//  Freshi
//
//  Created by Casey Roby on 6/10/21.
//

import SwiftUI

struct SignUpButtons: View {
    let submitLabel: String
    let submitButtonDisabled: Bool
    let onSubmit: () -> Void
    var hideBackButton: Bool
    let onBack: () -> Void?
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            // log in link
            HStack(alignment: .center, spacing: 5) {
                Text("Already have an account?")
                    .foregroundColor(Color("highContrast"))
                    .fontStyle(fontStyle: .subheadline)
                NavLink(label: "Log in", color: Color("interactiveFocus")) {
                    LogIn()
                }
                Spacer()
            }
            // Buttons
            HStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                // Show back button if not hidden.
                if !self.hideBackButton {
                    // Back Button
                    Button(action: {
                        self.onBack()
                    }) {
                        Image("back-arrow")
                    }
                    .stretchyButton(
                        state: StretchyButtonState.neutral,
                        isSquare: true)
                }
                // Next Button & Nav
                Button(self.submitLabel){
                    self.onSubmit()
                }
                // can't click button until enabled
                .disabled(self.submitButtonDisabled)
                .stretchyButton(
                    state: (
                        // next button has disabled style until username 3 char in length
                        self.submitButtonDisabled ?
                        StretchyButtonState.disabled :
                        StretchyButtonState.focused))
            }

        }
    }
}

struct SignUpButtons_Previews: PreviewProvider {
    static var previews: some View {
        SignUpButtons(
            submitLabel: "Next",
            submitButtonDisabled: false,
            onSubmit: {
                print("exited")},
            hideBackButton: false,
            onBack: {
                print("went back")
            })
    }
}

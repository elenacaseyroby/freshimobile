//
//  PasswordResetError.swift
//  Freshi
//
//  Created by Casey Roby on 6/21/21.
//

import SwiftUI


struct ResetPasswordError: View {
    @Binding var selection: String
    
    var body: some View {
        VStack {
            Header(
                title: "Freshi",
                onExit: {
                    withAnimation {
                        self.selection = "landing"
                    }
                })
            Spacer()
            VStack(alignment: .center, spacing: 20) {
                Text("Oh no! It looks like your password reset request has expired.")
                    .fontStyle(fontStyle: .headline)
                    .foregroundColor(Color("highContrast"))
                    .multilineTextAlignment(.center)
                Button("Request a new password reset email") {
                    withAnimation {
                        self.selection = "request-password-reset"
                    }
                }
                .fontStyle(fontStyle: .headline)
                .foregroundColor(Color("interactiveFocus"))
            }
            Spacer()
            Spacer()
        }
        .padding(.horizontal, GlobalStyles.padding)
        .background(Color("background"))
    }
}
// strictly for dev previews in xcode.
struct ResetPasswordError_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordError(
            selection: .constant("reset-password"))
    }
}

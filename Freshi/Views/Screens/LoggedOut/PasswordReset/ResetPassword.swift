//
//  ResetPassword.swift
//  Freshi
//
//  Created by Casey Roby on 6/14/21.
//

import SwiftUI


struct ResetPassword: View {
    @Binding var selection: String
    @State var password: String = ""
    @State var secondPassword: String = ""
    @State var errorMessage: String? = nil
    @State var apiErrorMessage: String? = nil
    @State var textboxIsActive: Bool = false
    @State var activeTextbox: ActiveTextbox = ActiveTextbox.none
    
    enum ActiveTextbox {
        case first, second, none
    }
    
    // func to decide state of textbox, ie which color border surrounds it.
    func textboxState(
        thisTextbox: ActiveTextbox,
        activeTextbox: ActiveTextbox,
        error: Bool) -> TextboxState {
        if error {
            return TextboxState.error
        }
        if activeTextbox == thisTextbox {
            return TextboxState.focused
        }
        return TextboxState.neutral
    }
    
    func submit() {
        // If passwords don't match, set error message.
        if self.password != self.secondPassword {
            self.errorMessage = "Passwords must match"
            return
        }
        // Check for errors
        let error = getPasswordError(password: self.password)
        // If error exists, show error and stay on page
        if error != nil {
            self.errorMessage = error
            return
        }
        print("set password")
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(
                    title: "Password Recovery",
                    onExit: {
                        self.selection = "landing"
                    })
                Line()
            }
            // Password label
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Choose a strong password")
                        .foregroundColor(Color("highContrast"))
                        .fontStyle(fontStyle: .headline)
                    Text("must be at least 8 characters")
                        .foregroundColor(Color("highContrast"))
                        .fontStyle(fontStyle: .subheadline)
                }
                Spacer()
            }
            // First password textbox
            SecureField("password", text: $password)
                .freshiPassword(
                    state: self.textboxState(
                        thisTextbox: ActiveTextbox.first,
                        activeTextbox: self.activeTextbox,
                        error: self.errorMessage != nil ? true : false),
                    onTap: {
                        self.activeTextbox = ActiveTextbox.first})
            VStack(alignment: .leading, spacing: 5){
                // Second password textbox
                SecureField("password", text: $secondPassword)
                    .freshiPassword(
                        state: self.textboxState(
                            thisTextbox: ActiveTextbox.second,
                            activeTextbox: self.activeTextbox,
                            error: self.errorMessage != nil ? true : false),
                        // Only show error message under second password
                        errorMessage: self.errorMessage,
                        onTap: {
                            self.activeTextbox = ActiveTextbox.second})
                // render API error message
                if let apiErrorMessage = self.apiErrorMessage {
                    FormErrorMessage(error: apiErrorMessage)
                }
            }
            // Make links and buttons closer together.
            VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                // Sign up link
                HStack(alignment: .center, spacing: 5) {
                    Text("Remember your password?")
                        .foregroundColor(Color("highContrast"))
                        .fontStyle(fontStyle: .subheadline)
                    Button("Log in") {
                            self.selection = "log-in"
                        }
                        .fontStyle(fontStyle: .subheadline)
                        .foregroundColor(Color("interactiveFocus"))
                    
                    Spacer()
                }
                // Submit button
                Button("Set New Password"){
                    self.submit()
                }
                // can't click button until enabled
                .disabled(
                    self.password.count < 8 ||
                    self.secondPassword.count < 8)
                .stretchyButton(
                    state: (
                        // disable button if password too short
                        (
                            self.password.count < 8 ||
                            self.secondPassword.count < 8) ?
                        StretchyButtonState.disabled :
                        StretchyButtonState.focused))
            }
            Spacer()
        }
        .padding(.horizontal, GlobalStyles.padding)
        .background(Color("background"))
        
    }
}
// strictly for dev previews in xcode.
struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassword(selection: .constant("reset-password"))
    }
}

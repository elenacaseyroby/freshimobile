//
//  Request Email.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct PasswordResetEmail: View {
    @Binding var selection: String
    @State var email: String = ""
    @State var errorMessage: String? = nil
    @State var apiErrorMessage: String? = nil
    @State var textboxIsActive: Bool = false
    
    // manages overlays and screen redirects
    @EnvironmentObject var screenManagerStore: ScreenManagerStore
    
    // func to decide state of textbox, ie which color border surrounds it.
    func textboxState(
        isActive: Bool,
        errorMessage: String?) -> TextboxState {
        if errorMessage != nil {
            return TextboxState.error
        } else if isActive {
            return TextboxState.focused
        }
        return TextboxState.neutral
    }
    
    
    func submit() {
        // Check for errors
        let error = getEmailError(email: self.email)
        // If error exists, show error and stay on page
        if error != nil {
            self.errorMessage = error
            return
        }
        // send email or throw api error
        self.sendEmail(email: self.email)
    }
    
    func sendEmail(email: String){
        DispatchQueue.main.async {
            // clear error message
            self.errorMessage = nil
            // Clear api errors
            self.apiErrorMessage = nil
            // make loader display while making API request
            showLoadingOverLayAction(screenManagerStore: self.screenManagerStore)
        }
        // Request is made
        passwordResetEmailRequest(
            email: email,
            onSuccess: {
                // Trigger alert: Woohoo! Your password reset email has been sent to ".."!
                withAnimation {
                    self.selection = "landing"
                }
            },
            onError: { requestError in
                // Push changes in state to the main thread to update UI.
                DispatchQueue.main.async {
                    if let apiErrorMessage = requestError.errorMessage {
                        self.apiErrorMessage = apiErrorMessage
                    }
                }
            },
            onComplete: {
                // Once response is processed, loading screen disappears.
                // Must send state update back to the main thread with DispatchQueue to update UI.
                hideLoadingOverLayAction(
                    screenManagerStore: self.screenManagerStore)
            })
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(
                    title: "Password Recovery",
                    onExit: {
                        withAnimation {
                            self.selection = "landing"
                        }
                    })
                Line()
            }
            // Email textbox
            VStack(alignment: .leading, spacing: 5){
                // Username textbox
                TextField("email", text: $email, onEditingChanged: {
                    (editingChanged) in
                    if editingChanged {
                        self.textboxIsActive = true
                    }
                })
                    .freshiLogin(
                        state: self.textboxState(
                            isActive: self.textboxIsActive,
                            errorMessage: self.errorMessage),
                        errorMessage: self.errorMessage
                    )
                // render API error message
                if let apiErrorMessage = self.apiErrorMessage {
                    FormErrorMessage(error: apiErrorMessage)
                }
            }
            // Make links and buttons closer together.
            VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                // Sign up link
                HStack(alignment: .center, spacing: 5) {
                    Text("New user?")
                        .foregroundColor(Color("highContrast"))
                        .fontStyle(fontStyle: .subheadline)
                    Button("Sign up") {
                        withAnimation {
                            self.selection = "sign-up"
                        }
                    }
                        .foregroundColor(Color("highContrast"))
                        .fontStyle(fontStyle: .subheadline)
                    Spacer()
                }
                // Submit button
                Button("Send Recovery Email"){
                    self.submit()
                }
                // can't click button until enabled
                .disabled(self.email.count < 5)
                .stretchyButton(
                    state: (
                        // next button has disabled style until email is valid
                        self.email.count < 5 ?
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
struct PasswordResetEmail_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetEmail(selection: .constant("log-in"))
    }
}

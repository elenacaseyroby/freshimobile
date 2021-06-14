//
//  Request Email.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct RequestPasswordReset: View {
    // State used to pop back one view
    @Environment(\.presentationMode) var presentationMode
    
    @State var email: String = ""
    @State var errorMessage: String? = nil
    @State var apiErrorMessage: String? = nil
    @State var textboxIsActive: Bool = false
    
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
        print("send email!")
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(
                    title: "Password Recovery",
                    onExit: {
                        self.presentationMode.wrappedValue.dismiss()
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
                    NavLink(label: "Sign up", color: Color("interactiveFocus")) {
                        SignUp()
                    }
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
        
    }
}
// strictly for dev previews in xcode.
struct RequestPasswordReset_Previews: PreviewProvider {
    static var previews: some View {
        RequestPasswordReset()
    }
}

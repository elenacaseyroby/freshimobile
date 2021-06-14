//
//  SignUpEmail.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct SignUpEmail: View {
    // args
    @Binding var email: String
    @Binding var currentPage: Float
    @Binding var apiErrorMessage: String?
    @Binding var apiErrorField: String?
    
    // vars
    @State var isActive: Bool = false
    @State var errorMessage: String? = nil
    
    func textboxState(
        isActive: Bool,
        errorMessage: String?,
        apiErrorField: String?) -> TextboxState {
        if let apiErrorField = apiErrorField {
            if apiErrorField == "email" {
                return TextboxState.error
            }
        }
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
        // If no error, show next set of textboxes
        self.currentPage += 1
    }
    
    var body: some View {
        VStack {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Enter your email address")
                            .foregroundColor(Color("highContrast"))
                            .fontStyle(fontStyle: .headline)
                    }
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 5){
                    // Username textbox
                    TextField("email", text: $email, onEditingChanged: {
                        (editingChanged) in
                        if editingChanged {
                            self.isActive = true
                        }
                    })
                        .freshiLogin(
                            state: self.textboxState(
                                isActive: self.isActive,
                                errorMessage: self.errorMessage,
                                apiErrorField: self.apiErrorField),
                            errorMessage: self.errorMessage
                        )
                    // render API error message
                    if self.apiErrorField == "email" {
                        if let apiErrorMessage = self.apiErrorMessage {
                            FormErrorMessage(error: apiErrorMessage)
                        }
                    }
                }
            }
            SignUpButtons(
                submitLabel: "Next",
                submitButtonDisabled: self.email.count < 5,
                onSubmit: self.submit,
                hideBackButton: self.currentPage == 1 ? true : false,
                onBack: {
                    self.currentPage -= 1
                })
        }
    }
}
// strictly for dev previews in xcode.
struct SignUpEmail_Previews: PreviewProvider {
    static var previews: some View {
        SignUpEmail(
            email: .constant("ecroby@gmail.com"),
            currentPage: .constant(1),
            apiErrorMessage: .constant("Email is too long"),
            apiErrorField: .constant("email"))
    }
}


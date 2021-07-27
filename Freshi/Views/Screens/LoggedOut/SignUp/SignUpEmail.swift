//
//  SignUpEmail.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct SignUpEmail: View {
    // args
    @Binding var selection: String
    @Binding var email: String
    @Binding var currentPage: Float
    @Binding var apiErrors: SignUpAPIErrors
    
    // vars
    @State var isActive: Bool = false
    @State var errorMessage: String? = nil
    
    func textboxState(
        isActive: Bool,
        apiErrors: SignUpAPIErrors,
        errorMessage: String?) -> TextboxState {
        // red border if api returns error regarding email
        if apiErrors.email != nil {
            return TextboxState.error
        }
        // red border if email error before submitting to api
        // ex. please enter valid email
        if errorMessage != nil {
            return TextboxState.error
        // focused border if textbox active
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
                                apiErrors: self.apiErrors,
                                errorMessage: self.errorMessage),
                            errorMessage: self.errorMessage
                        )
                    // render API error message
                    if let apiErrorMessage = self.apiErrors.email {
                        FormErrorMessage(error: apiErrorMessage)
                    }
                }
            }
            SignUpButtons(
                selection: $selection,
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
            selection: .constant("log-in"),
            email: .constant("ecroby@gmail.com"),
            currentPage: .constant(1),
            apiErrors: .constant(SignUpAPIErrors()))
    }
}


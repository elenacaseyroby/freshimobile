//
//  SignUpUsername.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import SwiftUI


struct SignUpUsername: View {
    // args
    @Binding var username: String
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
            if apiErrorField == "username" {
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
    
    func submit () {
        // Check for errors
        let error = getUsernameError(username: self.username)
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
                        Text("Choose a unique username")
                            .foregroundColor(Color("highContrast"))
                            .fontStyle(fontStyle: .headline)
                    }
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 5) {
                    // Username textbox
                    TextField("username", text: $username, onEditingChanged: {
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
                    if self.apiErrorField == "username" {
                        if let apiErrorMessage = self.apiErrorMessage {
                            FormErrorMessage(error: apiErrorMessage)
                        }
                    }
                }
            }
            SignUpButtons(
                submitLabel: "Next",
                submitButtonDisabled: self.username.count < 3,
                onSubmit: self.submit,
                hideBackButton: self.currentPage == 1 ? true : false,
                onBack: {
                    self.currentPage -= 1
                })
        }
    }
}
// strictly for dev previews in xcode.
struct SignUpUsername_Previews: PreviewProvider {
    static var previews: some View {
        SignUpUsername(
            username: .constant("ecroby"),
            currentPage: .constant(1),
            apiErrorMessage: .constant("Email is too long"),
            apiErrorField: .constant("email"))
    }
}

//
//  SignUpUsername.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import SwiftUI


struct SignUpUsername: View {
    // args
    @Binding var selection: String
    @Binding var username: String
    @Binding var currentPage: Float
    @Binding var apiErrors: SignUpAPIErrors
    
    // vars
    @State var isActive: Bool = false
    @State var errorMessage: String? = nil
    
    func textboxState(
        isActive: Bool,
        apiErrors: SignUpAPIErrors,
        errorMessage: String?) -> TextboxState {
        // red border if api error
        if apiErrors.username != nil {
            return TextboxState.error
        }
        // red border if error before hitting api
        // ex. username has less than 3 chars.
        if errorMessage != nil {
            return TextboxState.error
        }
        // active border is user is actively typing in box.
        if isActive {
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
                                apiErrors: self.apiErrors,
                                errorMessage: self.errorMessage),
                            errorMessage: self.errorMessage
                        )
                    // render API error message
                    if let apiErrorMessage = self.apiErrors.username {
                        FormErrorMessage(error: apiErrorMessage)
                    }
                }
            }
            SignUpButtons(
                selection: $selection,
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
            selection: .constant("log-in"),
            username: .constant("ecroby"),
            currentPage: .constant(1),
            apiErrors: .constant(SignUpAPIErrors()))
    }
}


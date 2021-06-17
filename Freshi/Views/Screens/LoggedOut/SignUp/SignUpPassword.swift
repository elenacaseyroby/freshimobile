//
//  SignUpPassword.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import Foundation
import SwiftUI


struct SignUpPassword: View {
    // args
    @Binding var password: String
    @Binding var email: String
    @Binding var username: String
    @Binding var currentPage: Float
    @Binding var apiErrorMessage: String?
    @Binding var apiErrorField: String?
    
    // authentication state for app
    @EnvironmentObject var authStore: AuthStore
    // manages overlays and screen redirects
    @EnvironmentObject var screenManagerStore: ScreenManagerStore
    
    // variables
    @State var secondPassword: String = ""
    
    @State var errorMessage: String? = nil
    @State var activeTextbox: ActiveTextbox = ActiveTextbox.none
    
    enum ActiveTextbox {
        case first, second, none
    }
    
    // func to decide state of textbox, ie which color border surrounds it.
    func textboxState(
        thisTextbox: ActiveTextbox,
        activeTextbox: ActiveTextbox,
        error: Bool,
        apiErrorField: String?) -> TextboxState {
        if let apiErrorField = apiErrorField {
            if apiErrorField == "password" {
                return TextboxState.error
            }
        }
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
        // If no error, create account & update state
        self.createUser(
            username: username,
            email: email,
            password: password)
        
    }
    
    func createUser(username: String, email: String, password: String) {
        DispatchQueue.main.async {
            // Clear api errors
            self.apiErrorField = nil
            self.apiErrorMessage = nil
            // make loader display while making API request
            showLoadingOverLayAction(screenManagerStore: self.screenManagerStore)
        }
        // Request is made
        createUserAction(
            username: username,
            email: email,
            password: password,
            onSuccess: { user in
                logInAction(
                    username: user.username,
                    password: password,
                    authStore: authStore,
                    onSuccess: {},
                    onError: { requestError in
                        if let requestError = requestError {
                            self.apiErrorMessage = requestError.errorMessage
                        }
                    }, onComplete: {
                        // Once response is processed, loading screen disappears.
                        // Must send state update back to the main thread with DispatchQueue to update UI.
                        DispatchQueue.main.async {
                            showSignUpConfirmationAction(
                                screenManagerStore: self.screenManagerStore)
                            hideLoadingOverLayAction(
                                screenManagerStore: self.screenManagerStore)
                        }
                    })
            },
            onError: { createUserError in
                // Push changes in state to the main thread to update UI.
                DispatchQueue.main.async {
                    if let field = createUserError.error_field {
                        self.apiErrorField = field
                    }
                    if let message = createUserError.error_message {
                        self.apiErrorMessage = message
                    }
                    // Once response is processed, loading screen disappears.
                    // Must send state update back to the main thread with DispatchQueue to update UI.
                    hideLoadingOverLayAction(
                        screenManagerStore: self.screenManagerStore)
                }
            },
            onComplete: {})
    }
    
    var body: some View {
        VStack {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
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
                            error: self.errorMessage != nil ? true : false,
                            apiErrorField: self.apiErrorField
                        ),
                        onTap: {
                            self.activeTextbox = ActiveTextbox.first})
                VStack(alignment: .leading, spacing: 5){
                    // Second password textbox
                    SecureField("password", text: $secondPassword)
                        .freshiPassword(
                            state: self.textboxState(
                                thisTextbox: ActiveTextbox.second,
                                activeTextbox: self.activeTextbox,
                                error: self.errorMessage != nil ? true : false,
                                apiErrorField: self.apiErrorField
                            ),
                            // Only show error message under second password
                            errorMessage: self.errorMessage,
                            onTap: {
                                self.activeTextbox = ActiveTextbox.second})
                    // render API error message
                    if (
                        self.apiErrorField == "password" ||
                        self.apiErrorField == nil ) {
                        // Show message if password related or server related
                        // (server related if no field specified).
                        if let apiErrorMessage = self.apiErrorMessage {
                            FormErrorMessage(error: apiErrorMessage)
                        }
                    }
                }
            }
            SignUpButtons(
                submitLabel: "Create account",
                submitButtonDisabled: (
                    self.password.count < 8 ||
                    self.secondPassword.count < 8),
                onSubmit: self.submit,
                hideBackButton: self.currentPage == 1 ? true : false,
                onBack: {
                    self.currentPage -= 1
                })
        }
        .onTapGesture {
            self.activeTextbox = ActiveTextbox.none
        }
    }
}
// strictly for dev previews in xcode.
struct SignUpPassword_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPassword(
            password: .constant("password"),
            email: .constant("email@email.com"),
            username: .constant("username"),
            currentPage: .constant(1),
            apiErrorMessage: .constant("Email is too long"),
            apiErrorField: .constant("email"))
    }
}

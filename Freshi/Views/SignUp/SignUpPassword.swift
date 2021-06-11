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
    
    // loader state controls when loading overlay shows in app
    @EnvironmentObject var loader: Loader
    
    // variables
    @State var secondPassword: String = ""
    
    @State var isActive: Bool = false
    @State var errorMessage: String? = nil
    @State var activeTextbox: ActiveTextbox = ActiveTextbox.none
    
    enum ActiveTextbox {
        case first, second, none
    }
    
    // func to decide state of textbox, ie which color border surrounds it.
    func textboxState(
        thisTextbox: ActiveTextbox,
        activeTextbox: ActiveTextbox,
        error: Bool
    ) -> TextboxState {
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
        // with Auth.loggedIn and Onboarding.complete = false (true by default)
        self.createUser(
            username: username,
            email: email,
            password: password)
        
    }
    
    func createUser(username: String, email: String, password: String) {
        // Loader screen appears
        DispatchQueue.main.async {
            loader.showLoadingOverlay = true
        }
        // Request is made
        createUserRequest(
            username: username,
            email: email,
            password: password,
            completionHandler: { user, requestError in
            if let user = user {
                // Update the state and thereby our UI
                print("~~~~~~~~~~")
                print(user)
                print("~~~~~~~~~~")
            }
            if let requestError = requestError {
                print("///////////////////////")
                print(requestError)
                print("///////////////////////")
            }
            // Once response is processed, loading screen disappears.
            // Must send state update back to the main thread with DispatchQueue to update UI.
            DispatchQueue.main.async {
                loader.showLoadingOverlay = false
            }
        })
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
                            error: self.errorMessage != nil ? true : false
                        ),
                        onTap: {
                            self.activeTextbox = ActiveTextbox.first})
                // Second password textbox
                SecureField("password", text: $secondPassword)
                    .freshiPassword(
                        state: self.textboxState(
                            thisTextbox: ActiveTextbox.second,
                            activeTextbox: self.activeTextbox,
                            error: self.errorMessage != nil ? true : false
                        ),
                        // Only show error message under second password
                        errorMessage: self.errorMessage,
                        onTap: {
                            self.activeTextbox = ActiveTextbox.second})
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
            currentPage: .constant(1))
    }
}

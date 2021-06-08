//
//  LogInView.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//

import SwiftUI


struct LogIn: View {
    // authentication state for app
    @EnvironmentObject var auth: Auth
    
    // loader state controls when loading overlay shows in app
    @EnvironmentObject var loader: Loader
    
    // username textbox state
    @State var username: String = ""
    @State var usernameError: Bool = false
    @State var usernameErrorMessage: String? = nil
    
    // password textbox state
    @State var password: String = ""
    @State var passwordError: Bool = false
    @State var passwordErrorMessage: String? = nil
    
    // focused textbox state
    @State var activeTextbox: ActiveTextbox = ActiveTextbox.none
    
    // API error message
    @State var apiErrorMessage: String? = nil
    
    enum ActiveTextbox {
        case username, password, none
    }
    
    // func to decide state of textbox, ie which color border surrounds it.
    func textboxState(
        thisTextbox: ActiveTextbox,
        activeTextBox: ActiveTextbox,
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
    
    // check that username and password are entered correctly before submitting to API.
    func checkForErrors() -> Bool {
        self.usernameError = false
        self.usernameErrorMessage = nil
        self.passwordError = false
        self.passwordErrorMessage = nil
        if self.username.count == 0 {
            self.usernameError = true
            self.usernameErrorMessage = "Please enter a username."
        }
        if self.password.count == 0 {
            self.passwordError = true
            self.passwordErrorMessage = "Please enter a password."
        }
        if self.passwordError || self.usernameError {
            return true
        }
        return false
    }
    
    // log in through API
    func logIn(username: String, password: String) {
        // On submit, show loading screen until API auths or denies.
        loader.showLoadingOverlay = true
        // clear API error message if there was one from a prev login:
        self.apiErrorMessage = nil
        // try login
        fetchAuthCreds(username: username, password: password, completionHandler: { authCreds, requestError in
            if let authCreds = authCreds {
                // Update the state and thereby our UI
                auth.logIn(authCreds: authCreds)
            }
            if let requestError = requestError {
                self.apiErrorMessage = requestError.errorMessage
            }
            // Once response is processed, loading screen disappears.
            // Must send state update back to the main thread with DispatchQueue to update UI.
            DispatchQueue.main.async {
                loader.showLoadingOverlay = false
            }
        })
    }
    
    func submit() {
        let errorsExist = self.checkForErrors()
        // if errors exist, don't try  to log in.
        if errorsExist {
            return
        }
        // else, log in.
        self.logIn(username: self.username, password: self.password)
        
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(title: "Log in")
                Line()
            }
            // Textboxes
            TextField("username", text: $username, onEditingChanged: {
                (editingChanged) in
                if editingChanged {
                    self.activeTextbox = ActiveTextbox.username
                }
            })
                .disableAutocorrection(true)
                .freshiUsername(
                    state: self.textboxState(
                        thisTextbox: ActiveTextbox.username,
                        activeTextBox: self.activeTextbox,
                        error: self.usernameError),
                    errorMessage: self.usernameErrorMessage
                )
            SecureField("password", text: $password)
                .freshiPassword(
                    state: self.textboxState(
                        thisTextbox: ActiveTextbox.password,
                        activeTextBox: self.activeTextbox,
                        error: self.passwordError),
                    errorMessage: self.passwordErrorMessage,
                    onTap: {
                        self.activeTextbox = ActiveTextbox.password})
            // render API error message
            if let apiErrorMessage = self.apiErrorMessage {
                FormErrorMessage(error: apiErrorMessage)
            }
    
            // Links
            HStack(alignment: .center, spacing: 5){
                SignUpNavLink()
                Image("dot")
                ResetPWNavLink(label: "Forgot username or password?")
            }
            // Buttons
            HStack(alignment: .center, spacing: 10){
                Button("Log in") {
                    self.activeTextbox = ActiveTextbox.none
                    self.submit()
                }
                .stretchyButton(state: StretchyButtonState.focused)
            }
            
            // Top align.
            Spacer()
        }
        .onTapGesture {
            self.activeTextbox = ActiveTextbox.none
        }
        .padding(.leading, GlobalStyles.padding)
        .padding(.trailing, GlobalStyles.padding)
        .background(Color("background"))
    }
}
// strictly for dev previews in xcode.
struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}


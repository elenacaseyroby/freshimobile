//
//  LogInView.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//

import SwiftUI

enum LoginActiveTextbox {
    case username, password, none
}

struct LogIn: View {
    // authentication state for app
    @EnvironmentObject var auth: Auth
    
    // username textbox state
    @State var username: String = ""
    @State var usernameError: Bool = false
    @State var usernameErrorMessage: String? = nil
    
    // password textbox state
    @State var password: String = ""
    @State var passwordError: Bool = false
    @State var passwordErrorMessage: String? = nil
    
    // focused textbox state
    @State var activeTextbox: LoginActiveTextbox = LoginActiveTextbox.none
    
    // API error message
    @State var apiErrorMessage: String? = nil
    
    // func to decide state of textbox, ie which color border surrounds it.
    func textboxState(
        thisTextbox: LoginActiveTextbox,
        activeTextBox: LoginActiveTextbox,
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
    
    func printAuth(){
        print(auth.creds ?? "no creds")
    }
    
    // log in through API
    func logIn(username: String, password: String) {
        // set loading state to true
        // hit api
        // wait for return
        // on return:
        // set loading state to false and
        // set error message if need be
        
        print("hit api!!")
        fetchAuthCreds(username: username, password: password, completionHandler: { authCreds, requestError in
            if let authCreds = authCreds {
                // If we have data, send it back to the main thread with DispatchQueue.
                DispatchQueue.main.async {
                    // Update the state and thereby our UI
                    auth.creds = authCreds
                }
            }
            if let requestError = requestError {
                self.apiErrorMessage = requestError.errorMessage
                return
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
            TextField("Username", text: $username, onEditingChanged: {
                (editingChanged) in
                if editingChanged {
                    self.activeTextbox = LoginActiveTextbox.username
                }
            })
                .disableAutocorrection(true)
                .freshiTextbox(
                    state: self.textboxState(
                        thisTextbox: LoginActiveTextbox.username,
                        activeTextBox: self.activeTextbox,
                        error: self.usernameError),
                    errorMessage: self.usernameErrorMessage
                )
            SecureField("Enter a password", text: $password)
                .freshiTextbox(
                    state: self.textboxState(
                        thisTextbox: LoginActiveTextbox.password,
                        activeTextBox: self.activeTextbox,
                        error: self.passwordError),
                    errorMessage: self.passwordErrorMessage
                )
                .onTapGesture {
                    self.activeTextbox = LoginActiveTextbox.password
                }
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
                    self.activeTextbox = LoginActiveTextbox.none
                    self.submit()
                }
                .stretchyButton(state: StretchyButtonState.focused)
            }
            
            // Top align.
            Spacer()
        }
        .onTapGesture {
            self.activeTextbox = LoginActiveTextbox.none
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


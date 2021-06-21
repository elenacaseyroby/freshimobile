//
//  LogInView.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//

import SwiftUI


struct LogIn: View {
    @Binding var selection: String
    // Authentication state for app
    @EnvironmentObject var authStore: AuthStore
    
    // Manages overlays and screen redirects.
    @EnvironmentObject var screenManagerStore: ScreenManagerStore
    
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
    
    // State to control exit icon
    @State var navToRoot: Bool = false
    
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
    
    func clearErrorMessages() {
        self.usernameError = false
        self.usernameErrorMessage = nil
        self.passwordError = false
        self.passwordErrorMessage = nil
    }
    
    // log in through API
    func logIn(username: String, password: String) {
        // On submit, show loading screen until API auths or denies.
        showLoadingOverLayAction(screenManagerStore: self.screenManagerStore)
        // clear API error message if there was one from a prev login:
        self.apiErrorMessage = nil
        // try login
        logInAction(
            username: username,
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
                    hideLoadingOverLayAction(screenManagerStore: self.screenManagerStore)
                }
            })
    }
    
    func submit() {
        // check that username and password are entered correctly before submitting to API.
        self.clearErrorMessages()
        self.usernameErrorMessage = getUsernameError(username: self.username)
        if self.usernameErrorMessage != nil {
            self.usernameError = true
        }
        self.passwordErrorMessage = getPasswordError(password: self.password)
        if self.passwordErrorMessage != nil {
            self.passwordError = true
        }
        // if errors exist, don't try  to log in.
        if (
            self.usernameErrorMessage != nil ||
            self.passwordErrorMessage != nil ) {
            return
        }
        // else, log in.
        self.logIn(username: self.username, password: self.password)
        
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(
                    title: "Log in",
                    onExit: {
                        self.selection = "landing"
                    })
                Line()
            }
            // Textboxes
            TextField("username", text: $username, onEditingChanged: {
                (editingChanged) in
                if editingChanged {
                    self.activeTextbox = ActiveTextbox.username
                }
            })
                .freshiLogin(
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
            // Make links and buttons closer together.
            VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                // Links
                HStack(alignment: .center, spacing: 5){
                    Button("Sign up") {
                        self.selection = "sign-up"
                    }
                        .fontStyle(fontStyle: .subheadline)
                        .foregroundColor(Color("interactiveFocus"))
                    Image("dot")
                    Button("Forgot username or password?") {
                        self.selection = "request-password-reset"
                    }
                        .fontStyle(fontStyle: .subheadline)
                        .foregroundColor(Color("interactiveFocus"))
                }
                // Buttons
                Button("Log in") {
                    self.activeTextbox = ActiveTextbox.none
                    self.submit()
                }
                .disabled(self.username.count < 3 || self.password.count < 6)
                .stretchyButton(state: (
                    (self.username.count < 3 || self.password.count < 6) ?
                    StretchyButtonState.disabled :
                    StretchyButtonState.focused))
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
        LogIn(selection: .constant("log-in"))
    }
}


//
//  PasswordReset.swift
//  Freshi
//
//  Created by Casey Roby on 6/14/21.
//

import SwiftUI


struct PasswordReset: View {
    @Binding var selection: String
    @State var url: URL? = nil
    @State var password: String = ""
    @State var secondPassword: String = ""
    @State var errorMessage: String? = nil
    @State var apiErrorMessage: String? = nil
    @State var textboxIsActive: Bool = false
    @State var activeTextbox: ActiveTextbox = ActiveTextbox.none
    
    @State var showAlert: Bool = false
    
    // These are extracted from the url.
    @State var authToken: String? = nil
    @State var userId: Int? = nil
    
    // authentication state for app
    @EnvironmentObject var authStore: AuthStore
    // manages overlays and screen redirects
    @EnvironmentObject var screenManagerStore: ScreenManagerStore
    
    enum ActiveTextbox {
        case first, second, none
    }
    
    func extractInfoFromURL(url: URL) {
        if let query = url.query {
            let queryComponents = queryComponents(query: query)
            if let authToken = queryComponents["authToken"]{
                self.authToken = authToken
            }
            if let userId = queryComponents["userId"] {
                self.userId = Int(userId)
            }
        }
    }
    
    // func to decide state of textbox, ie which color border surrounds it.
    func textboxState(
        thisTextbox: ActiveTextbox,
        activeTextbox: ActiveTextbox,
        error: Bool) -> TextboxState {
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
        if let authToken = authToken {
            setPassword(password: password, authToken: authToken)
        } else {
            // Show error alert if no authToken was passed in url.
            showAlert.toggle()
        }
    }
    
    func setPassword(password: String, authToken: String) {
        DispatchQueue.main.async {
            // clear error message
            self.errorMessage = nil
            // Clear api errors
            self.apiErrorMessage = nil
            // make loader display while making API request
            showLoadingOverLayAction(screenManagerStore: self.screenManagerStore)
        }
        resetPasswordAction(
            password: password,
            authToken: authToken,
            authStore: authStore,
            onSuccess: {},
            onError: { requestError in
                self.apiErrorMessage = requestError.errorMessage
                if requestError.statusCode == 401 {
                    // If there is an authentication error
                    // then the auth token has likely expired.
                    // In this case nullify the token and userId
                    // so that the PasswordResetError screen renders.
                    self.authToken = nil
                    self.userId = nil
                }
                print(requestError.statusCode)
            },
            onComplete: {
                DispatchQueue.main.async {
                    hideLoadingOverLayAction(
                        screenManagerStore: self.screenManagerStore)
                }
            }
        )
    }
    
    var body: some View {
        VStack {
            if (
                self.authToken == nil ||
                self.userId == nil) {
                PasswordResetError(selection: $selection)
            } else {
                VStack(alignment: .center, spacing: 20){
                    // Header
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                        Header(
                            title: "Password Recovery",
                            onExit: {
                                withAnimation {
                                    self.selection = "landing"
                                }
                            })
                        Line()
                    }
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
                                error: self.errorMessage != nil ? true : false),
                            onTap: {
                                self.activeTextbox = ActiveTextbox.first})
                    VStack(alignment: .leading, spacing: 5){
                        // Second password textbox
                        SecureField("password", text: $secondPassword)
                            .freshiPassword(
                                state: self.textboxState(
                                    thisTextbox: ActiveTextbox.second,
                                    activeTextbox: self.activeTextbox,
                                    error: self.errorMessage != nil ? true : false),
                                // Only show error message under second password
                                errorMessage: self.errorMessage,
                                onTap: {
                                    self.activeTextbox = ActiveTextbox.second})
                        // render API error message
                        if let apiErrorMessage = self.apiErrorMessage {
                            FormErrorMessage(error: apiErrorMessage)
                        }
                    }
                    // Make links and buttons closer together.
                    VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                        // Sign up link
                        HStack(alignment: .center, spacing: 5) {
                            Text("Remember your password?")
                                .foregroundColor(Color("highContrast"))
                                .fontStyle(fontStyle: .subheadline)
                            Button("Log in") {
                                    withAnimation {
                                        self.selection = "log-in"
                                    }
                                }
                                .fontStyle(fontStyle: .subheadline)
                                .foregroundColor(Color("interactiveFocus"))
                            
                            Spacer()
                        }
                        // Submit button
                        Button("Set New Password"){
                            self.submit()
                        }
                        // can't click button until enabled
                        .disabled(
                            self.password.count < 8 ||
                            self.secondPassword.count < 8)
                        .stretchyButton(
                            state: (
                                // disable button if password too short
                                (
                                    self.password.count < 8 ||
                                    self.secondPassword.count < 8) ?
                                StretchyButtonState.disabled :
                                StretchyButtonState.focused))
                    }
                    Spacer()
                }
                .alert(isPresented:$showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text("There has been an error. Please request a new password reset email"),
                        dismissButton:.default(
                            Text("Request email"),
                            action: {
                                withAnimation {
                                    self.selection = "request-password-reset"
                                }
                            })
                    )
                }
                .padding(.horizontal, GlobalStyles.padding)
                .background(Color("background"))
            }
        }
        .onAppear(){
            if let url = self.url {
                self.extractInfoFromURL(url: url)
            }
        }
        .onChange(of: self.url, perform: { newUrl in
            if let url = newUrl {
                self.extractInfoFromURL(url: url)
            }
        })
    }
}
// strictly for dev previews in xcode.
struct PasswordReset_Previews: PreviewProvider {
    static var previews: some View {
        PasswordReset(
            selection: .constant("reset-password"),
            url: URL(string: "freshi://localhost:8000/reset-password?userId=10&authToken=aksdlkhgjshakfh")!)
    }
}

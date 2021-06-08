//
//  SignUpUsername.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import SwiftUI


struct SignUpUsername: View {
    // This will only be set if you get to the last page of the form, submit and it fails and gets naved back here.
    var apiErrorMessage: String? = nil
    
    @State var username: String = ""
    
    var currentPage: Float = 1
    var totalPages: Float = 4
    
    @State var isActive: Bool = false
    @State var errorMessage: String? = nil
    @State var navigateToNextPage: Bool = false
    
    func textboxState(
        isActive: Bool,
        errorMessage: String? ) -> TextboxState {
        if errorMessage != nil {
            return TextboxState.error
        } else if isActive {
            return TextboxState.focused
        }
        return TextboxState.neutral
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(title: "Create an account")
                // Show progress from last page to current page.
                ProgressBar(
                    fromPercent: percentAsDecimal(
                        value: self.currentPage - 1, total: self.totalPages),
                    toPercent: percentAsDecimal(
                        value: self.currentPage, total: self.totalPages)
                )
            }
            // Form
            
            // Username label
            HStack(alignment: .center, spacing: 5) {
                Text("Choose a unique username")
                    .foregroundColor(Color("highContrast"))
                    .fontStyle(fontStyle: .headline)
                Spacer()
            }
            // Username textbox
            TextField("username", text: $username, onEditingChanged: {
                (editingChanged) in
                if editingChanged {
                    self.isActive = true
                }
            })
                .freshiUsername(
                    state: self.textboxState(
                        isActive: self.isActive,
                        errorMessage: self.errorMessage),
                    errorMessage: self.errorMessage
                )
            // render API error message
            if let apiErrorMessage = self.apiErrorMessage {
                FormErrorMessage(error: apiErrorMessage)
            }
            // log in link
            HStack(alignment: .center, spacing: 5) {
                Text("Already have an account?")
                    .foregroundColor(Color("highContrast"))
                    .fontStyle(fontStyle: .callout)
                NavLink(label: "Log in", color: Color("interactiveFocus")) {
                    LogIn()
                }
                Spacer()
            }
            // Next Button & Nav
            Button("Next"){
                let error = getUsernameError(username: self.username)
                // If error exists, show error and stay on page
                if error != nil {
                    self.errorMessage = error
                    return
                }
                // If no error, nav to next page
                self.navigateToNextPage = true
            }
            // can't click button until username 3 char in length
            .disabled(self.username.count < 3)
            .stretchyButton(
                state: (
                    // next button has disabled style until username 3 char in length
                    self.username.count < 3 ?
                    StretchyButtonState.disabled :
                    StretchyButtonState.focused))
            
            // Navigates to next page with nav link if navigateToNextPage is true.
            ConditionalNav(navigateToDestination: self.navigateToNextPage) {
                SignUpEmail(username: $username)
            }
            
        }
        .background(Color("background"))
        .padding(.leading, GlobalStyles.padding)
        .padding(.trailing, GlobalStyles.padding)
        Spacer()
    }
}
// strictly for dev previews in xcode.
struct SignUpUsername_Previews: PreviewProvider {
    static var previews: some View {
        SignUpUsername()
    }
}


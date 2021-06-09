//
//  SignUpPassword.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import Foundation
import SwiftUI


struct SignUpPassword: View {
    @Binding var username: String
    @Binding var email: String
    // State to control exit icon
    @Binding var navToRoot: Bool
    

    // This will only be set if you get to the last page of the form, submit and it fails and gets naved back here.
    var apiErrorMessage: String? = nil
    
    @State var password: String = ""
    
    // controls progress bar
    var currentPage: Float = 3
    var totalPages: Float = 4
    
    @State var isActive: Bool = false
    @State var errorMessage1: String? = nil
    @State var errorMessage2: String? = nil
    @State var navigateToNextPage: Bool = false
    // focused textbox state
    @State var activeTextbox: ActiveTextbox = ActiveTextbox.none
    
    enum ActiveTextbox {
        case first, second, none
    }
    
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
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(
                    title: "Create an account",
                    onExit: {
                        self.navToRoot = true
                    })
                // Show progress from last page to current page.
                ProgressBar(
                    fromPercent: percentAsDecimal(
                        value: self.currentPage - 1, total: self.totalPages),
                    toPercent: percentAsDecimal(
                        value: self.currentPage, total: self.totalPages)
                )
            }
            // Form
            
            // Password label
            HStack(alignment: .center, spacing: 5) {
                Text("Choose a strong password")
                    .foregroundColor(Color("highContrast"))
                    .fontStyle(fontStyle: .headline)
                Spacer()
            }
            // Password textbox 1
            SecureField("password", text: $password)
                .freshiPassword(
                    state: TextboxState.neutral,
//                    state: self.textboxState(
//                        thisTextbox: ActiveTextbox.first,
//                        activeTextBox: self.activeTextbox,
//                        error: false),
                    errorMessage: self.errorMessage1,
                    onTap: {
                        self.activeTextbox = ActiveTextbox.first})
            // Password textbox 2
//            SecureField("password", text: $password)
//                .freshiPassword(
//                    state: TextboxState.neutral,
////                    state: self.textboxState(
////                        thisTextbox: ActiveTextbox.first,
////                        activeTextBox: self.activeTextbox,
////                        error: false),
//                    errorMessage: self.errorMessage1,
//                    onTap: {
//                        self.activeTextbox = ActiveTextbox.first})
            // render API error message
            if let apiErrorMessage = self.apiErrorMessage {
                FormErrorMessage(error: apiErrorMessage)
            }
            VStack(alignment: .center, spacing: 10) {
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
                Button("Next") {
//                    let error1 = getPasswordError(password: self.password1)
//                    // If error exists, show error and stay on page
//                    if error != nil {
//                        self.errorMessage1 = error
//                        return
//                    }
//                    // If no error, nav to next page
                    self.navigateToNextPage = true
                }
                // can't click button until email 5 char in length
                .disabled(self.password.count < 8)
                .stretchyButton(
                    state: (
                        // next button has disabled style until email 5 char in length
                        self.password.count < 8 ?
                        StretchyButtonState.disabled :
                        StretchyButtonState.focused))
            }
            
            // Navigates to next page with nav link if navigateToNextPage is true.
            ConditionalNav(navigateToDestination: self.navigateToNextPage) {
                SignUpComplete()
            }
            Spacer()
        }
        .background(Color("background"))
        .padding(.leading, GlobalStyles.padding)
        .padding(.trailing, GlobalStyles.padding)
        .onAppear() {
            // keyboard appears immediately
        }
        .onTapGesture {
            self.activeTextbox = ActiveTextbox.none
        }
        .popToRootNavView(navToRoot: $navToRoot)
    }
}
//// strictly for dev previews in xcode.
//struct SignUpPassword_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpPassword(username: <#T##Binding<String>#>, password: <#T##Binding<String>#>)
//    }
//}

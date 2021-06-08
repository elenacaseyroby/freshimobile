//
//  SignUpEmail.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//
//import SwiftUI
//
//
//struct SignUp: View {
//    @State var currentPage: Float = 1
//    var totalPages: Float = 4
//    
//    // loader state controls when loading overlay shows in app
//    @EnvironmentObject var loader: Loader
//    
//    // username textbox state
//    @State var username: String = ""
////    @State var usernameError: Bool = false
////    @State var usernameErrorMessage: String? = nil
//    
//    // email textbox state
//    @State var email: String = ""
////    @State var emailError: Bool = false
////    @State var emailErrorMessage: String? = nil
//    
//    // password textbox state
//    @State var password: String = ""
////    @State var passwordError: Bool = false
////    @State var passwordErrorMessage: String? = nil
//    
//    // determines which textbox is focused.
//    @State var activeTextbox: ActiveTextbox = ActiveTextbox.none
//    
//    // API error message
//    @State var apiErrorMessage: String? = nil
//    
//    enum ActiveTextbox {
//        case username, email, password, none
//    }
//    
//    
//    // func to decide state of textbox, ie which color border surrounds it.
//    func textboxState(
//        thisTextbox: ActiveTextbox,
//        activeTextBox: ActiveTextbox,
//        error: Bool
//    ) -> TextboxState {
//        if error {
//            return TextboxState.error
//        }
//        if activeTextbox == thisTextbox {
//            return TextboxState.focused
//        }
//        return TextboxState.neutral
//    }
//    
//    // check that username and password are entered correctly before submitting to API.
//    func checkForErrors() -> Bool {
//        self.usernameError = false
//        self.usernameErrorMessage = nil
//        self.passwordError = false
//        self.passwordErrorMessage = nil
//        if self.username.count == 0 {
//            self.usernameError = true
//            self.usernameErrorMessage = "Please enter a username."
//        }
//        if self.password.count == 0 {
//            self.passwordError = true
//            self.passwordErrorMessage = "Please enter a password."
//        }
//        if self.passwordError || self.usernameError {
//            return true
//        }
//        return false
//    }
//    
//    func percent(value: Float, total: Float) -> CGFloat {
//        let percent: Float = value / total
//        let roundedPercent = roundToDecPlace(value: percent, place: 2)
//        return CGFloat(roundedPercent)
//    }
//    
//    var body: some View {
//        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
//            // Header
//            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
//                Header(title: "Sign up")
//                // Show progress from last page to current page.
//                ProgressBar(
//                    fromPercent: percent(
//                        value: self.currentPage - 1, total: self.totalPages),
//                    toPercent: percent(
//                        value: self.currentPage, total: self.totalPages)
//                )
//                SignUpForm()
//                
//            }
//            // Top aligned
//            Spacer()
//        }
//        .background(Color("background"))
//        .padding(.leading, GlobalStyles.padding)
//        .padding(.trailing, GlobalStyles.padding)
//        
//    }
//}
//// strictly for dev previews in xcode.
//struct SignUp_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUp()
//    }
//}

import SwiftUI


struct SignUpEmail: View {
    var username: Binding<String>
    var body: some View {
        Text("Sign up email")
    }
}
//// strictly for dev previews in xcode.
//struct SignUpEmail_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpEmail(username: username)
//    }
//}


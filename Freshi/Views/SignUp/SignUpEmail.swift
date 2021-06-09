////
////  SignUpEmail.swift
////  Freshi
////
////  Created by Casey Roby on 6/1/21.
////
//
//import Foundation
//import SwiftUI
//
//
//struct SignUpEmail: View {
//    @Binding var username: String
//    // State to control exit icon
//    @Binding var navToRoot: Bool
//    // This will only be set if you get to the last page of the form, submit and it fails and gets naved back here.
//    var apiErrorMessage: String? = nil
//    
//    @State var email: String = ""
//    
//    // controls progress bar
//    var currentPage: Float = 2
//    var totalPages: Float = 4
//    
//    @State var isActive: Bool = false
//    @State var errorMessage: String? = nil
//    @State var navigateToNextPage: Bool = false
//    
//    // State to control back arrow
//    @Environment(\.presentationMode) var presentationMode
//    
//    func textboxState(
//        isActive: Bool,
//        errorMessage: String? ) -> TextboxState {
//        if errorMessage != nil {
//            return TextboxState.error
//        } else if isActive {
//            return TextboxState.focused
//        }
//        return TextboxState.neutral
//    }
//    
//    var body: some View {
//        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
//            // Header
//            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
//                Header(
//                    title: "Create an account",
//                    onExit: {
//                        self.navToRoot = true
//                    })
//                // Show progress from last page to current page.
//                ProgressBar(
//                    fromPercent: percentAsDecimal(
//                        value: self.currentPage - 1, total: self.totalPages),
//                    toPercent: percentAsDecimal(
//                        value: self.currentPage, total: self.totalPages)
//                )
//            }
//            // Form
//            
//            // Email label
//            HStack(alignment: .center, spacing: 5) {
//                Text("Enter your email address")
//                    .foregroundColor(Color("highContrast"))
//                    .fontStyle(fontStyle: .headline)
//                Spacer()
//            }
//            // Email textbox
//            TextField("email", text: $email, onEditingChanged: {
//                (editingChanged) in
//                if editingChanged {
//                    self.isActive = true
//                }
//            })
//                .freshiLogin(
//                    state: self.textboxState(
//                        isActive: self.isActive,
//                        errorMessage: self.errorMessage),
//                    errorMessage: self.errorMessage
//                )
//            // render API error message
//            if let apiErrorMessage = self.apiErrorMessage {
//                FormErrorMessage(error: apiErrorMessage)
//            }
//            VStack(alignment: .center, spacing: 10) {
//                // log in link
//                HStack(alignment: .center, spacing: 5) {
//                    Text("Already have an account?")
//                        .foregroundColor(Color("highContrast"))
//                        .fontStyle(fontStyle: .callout)
//                    NavLink(label: "Log in", color: Color("interactiveFocus")) {
//                        LogIn()
//                    }
//                    Spacer()
//                }
//                // Back Button
//                HStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
//                    Button(action: {
//                        self.presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Image("back-arrow")
//                    }
//                    .stretchyButton(
//                        state: StretchyButtonState.neutral,
//                        isSquare: true)
//                    // Next Button & Nav
//                    Button("Next"){
//                        let error = getEmailError(email: self.email)
//                        // If error exists, show error and stay on page
//                        if error != nil {
//                            self.errorMessage = error
//                            return
//                        }
//                        // If no error, nav to next page
//                        self.navigateToNextPage = true
//                    }
//                    // can't click button until email 5 char in length
//                    .disabled(self.email.count < 5)
//                    .stretchyButton(
//                        state: (
//                            // next button has disabled style until email 5 char in length
//                            self.email.count < 5 ?
//                            StretchyButtonState.disabled :
//                            StretchyButtonState.focused))
//                    // Navigates to next page with nav link if navigateToNextPage is true.
//                    ConditionalNav(navigateToDestination: self.navigateToNextPage) {
//                        SignUpPassword(
//                            username: $username,
//                            email: $email,
//                            navToRoot: $navToRoot)
//                    }
//                }
//            }
//            Spacer()
//        }
//        .background(Color("background"))
//        .padding(.leading, GlobalStyles.padding)
//        .padding(.trailing, GlobalStyles.padding)
//        .onAppear() {
//            // keyboard appears immediately
//        }
//        .popToRootNavView(navToRoot: $navToRoot)
//        
//    }
//}
////// strictly for dev previews in xcode.
////struct SignUpEmail_Previews: PreviewProvider {
////    static var previews: some View {
////        SignUpEmail(username: <#T##Binding<String>#>)
////    }
////}
//

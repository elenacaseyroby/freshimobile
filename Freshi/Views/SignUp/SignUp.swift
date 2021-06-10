//
//  SignUp.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import SwiftUI


struct SignUp: View {
    // Tracks form state.
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    // This will only be set if you get to the last page of the form, submit and it fails and gets naved back here.
    @State var apiErrorMessage: String? = nil
    
    // Controls whether you can click next.
    // This will be updated within textbox views.
    @State var nextButtonDisabled: Bool = true
    
    // Controls when to check for error messages and submit.
    @State var nextPressed: Bool = false
    
    // Controls progress bar.
    @State var currentPage: Float = 1
    var totalPages: Float = 4
    
    @State var isActive: Bool = false
    @State var errorMessage: String? = nil
    @State var navigateToNextPage: Bool = false
    
    // State used to pop back one view
    @Environment(\.presentationMode) var presentationMode
    
    func usernameNextButtonDisabled(username: String) -> Bool {
        // enable next button when user has entered min num chars.
        if username.count < 3 {
            return true
        }
        return false
    }
    func emailNextButtonDisabled(email: String) -> Bool {
        // enable next button when email has entered min num chars.
        if email.count < 5 {
            return true
        }
        return false
    }
    
    func passwordNextButtonDisabled(password: String) -> Bool {
        // enable next button when pw has entered min num chars.
        print("checking pw count")
        print(password.count)
        if password.count < 8 {
            return true
        }
        print("next button enabled!")
        return false
    }
    
    var pages: [Float: String] = [
        1: "username",
        2: "email",
        3: "password",
//        4: "complete", this is its own page now
    ]
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(
                    title: self.currentPage < 4 ? "Create an account" : "Success!",
                    onExit: {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                // Show progress from last page to current page.
                ProgressBar(
                    fromPercent: CGFloat(percentAsDecimal(
                        value: self.currentPage - 1, total: self.totalPages)),
                    toPercent: CGFloat(percentAsDecimal(
                        value: self.currentPage, total: self.totalPages))
                )
            }
            // Form
            if pages[self.currentPage] == "username" {
                SignUpUsername(
                    username: $username,
                    nextPressed: $nextPressed,
                    currentPage: $currentPage)
            }
            if pages[self.currentPage] == "email" {
                SignUpEmail(
                    email: $email,
                    nextPressed: $nextPressed,
                    currentPage: $currentPage)
            }
            if pages[self.currentPage] == "password" {
                SignUpPassword(
                    password: $password,
                    nextPressed: $nextPressed,
                    currentPage: $currentPage)
            }
            // render API error message
            if let apiErrorMessage = self.apiErrorMessage {
                FormErrorMessage(error: apiErrorMessage)
            }
            Spacer()
        }
        .background(Color("background"))
        .padding(.leading, GlobalStyles.padding)
        .padding(.trailing, GlobalStyles.padding)
        .onAppear() {
            // keyboard appears immediately
        }
        // Manage whether next button is disabled.
        .onChange(of: currentPage) { newValue in
            if pages[newValue] == "username" {
                self.nextButtonDisabled = usernameNextButtonDisabled(
                    username: username)
            } else if pages[newValue] == "email" {
                self.nextButtonDisabled = emailNextButtonDisabled(
                    email: email)
            } else if pages[newValue] == "password" {
                self.nextButtonDisabled = passwordNextButtonDisabled(
                    password: password)
            }
        }
        .onChange(of: username) { newValue in
            if pages[self.currentPage] == "username" {
                self.nextButtonDisabled = usernameNextButtonDisabled(
                    username: username)
            }
        }
        .onChange(of: email) { newValue in
            if pages[self.currentPage] == "email" {
                self.nextButtonDisabled = emailNextButtonDisabled(
                    email: email)
            }
        }
        .onChange(of: password) { newValue in
            if pages[self.currentPage] == "password" {
                self.nextButtonDisabled = passwordNextButtonDisabled(
                    password: password)
            }
        }
    }
}
// strictly for dev previews in xcode.
struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}

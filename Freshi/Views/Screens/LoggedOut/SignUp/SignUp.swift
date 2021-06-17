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
    @State var apiErrorField: String? = nil
    
    // State used to pop back one view
    @Environment(\.presentationMode) var presentationMode
    
    // Controls progress bar.
    @State var currentPage: Float = 1
    var totalPages: Float = 4
    
    // controls which page is shown in what order
    var pages: [Float: String] = [
        1: "username",
        2: "email",
        // this page has the API request that creates the account:
        3: "password",
//        4: "complete", this is its own page now
    ]
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(
                    title: "Create an account",
                    onExit: {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                // Show progress from last page to current page.
                ProgressBar(
                    currentPage: $currentPage,
                    totalPages: self.totalPages
                )
            }
            // Form
            if pages[self.currentPage] == "username" {
                SignUpUsername(
                    username: $username,
                    currentPage: $currentPage,
                    apiErrorMessage: $apiErrorMessage,
                    apiErrorField: $apiErrorField)
            }
            if pages[self.currentPage] == "email" {
                SignUpEmail(
                    email: $email,
                    currentPage: $currentPage,
                    apiErrorMessage: $apiErrorMessage,
                    apiErrorField: $apiErrorField)
            }
            if pages[self.currentPage] == "password" {
                SignUpPassword(
                    password: $password,
                    email: $email,
                    username: $username,
                    currentPage: $currentPage,
                    apiErrorMessage: $apiErrorMessage,
                    apiErrorField: $apiErrorField)
            }
            Spacer()
        }
        .padding(.horizontal, GlobalStyles.padding)
        .background(Color("background"))
        .onAppear() {
            // keyboard appears immediately
        }
        .onChange(of: apiErrorField, perform: { field in
            // if nil do nothing
            if field == nil {
                return
            }
            // If api returns error, show page relevant to error.
            for key in self.pages.keys {
                if self.pages[key] == field {
                    self.currentPage = key
                }
                if self.pages[key] == field {
                    self.currentPage = key
                }
                if self.pages[key] == field {
                    self.currentPage = key
                }
            }
                
        })
    }
}
// strictly for dev previews in xcode.
struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
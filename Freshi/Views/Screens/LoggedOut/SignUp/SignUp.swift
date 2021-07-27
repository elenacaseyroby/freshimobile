//
//  SignUp.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import SwiftUI

struct SignUpAPIErrors: Codable, Equatable {
    var email: String?
    var password: String?
    var username: String?
    var server: String?
}

struct SignUp: View {
    @Binding var selection: String
    // Tracks form state.
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    // This will only be set if you get to the last page of the form, submit and it fails and gets naved back here.
    @State var apiErrors: SignUpAPIErrors = SignUpAPIErrors()
    
//    @State var apiErrorMessage: String? = nil
//    @State var apiErrorField: String? = nil
    
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
                        withAnimation {
                            self.selection = "landing"
                        }
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
                    selection: $selection,
                    username: $username,
                    currentPage: $currentPage,
                    apiErrors: $apiErrors)
            }
            if pages[self.currentPage] == "email" {
                SignUpEmail(
                    selection: $selection,
                    email: $email,
                    currentPage: $currentPage,
                    apiErrors: $apiErrors)
            }
            if pages[self.currentPage] == "password" {
                SignUpPassword(
                    selection: $selection,
                    password: $password,
                    email: $email,
                    username: $username,
                    currentPage: $currentPage,
                    apiErrors: $apiErrors)
            }
            Spacer()
        }
        .padding(.horizontal, GlobalStyles.padding)
        .background(Color("background"))
        .onAppear() {
            // keyboard appears immediately
        }
        .onChange(of: apiErrors, perform: { field in
            // If api returns error, show page relevant to error.
            // Find first page with errors:
            var currentPageTitle = ""
            if apiErrors.username != nil {
                currentPageTitle = "username"
            } else if apiErrors.email != nil {
                currentPageTitle = "email"
            } else if apiErrors.password != nil {
                currentPageTitle = "password"
            }
            // Then set current page to that page.
            for (pageNumber, pageTitle) in self.pages {
                if pageTitle == currentPageTitle {
                    self.currentPage = pageNumber
                }
            }
        })
    }
}
// strictly for dev previews in xcode.
struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(selection: .constant("sign-up"))
    }
}

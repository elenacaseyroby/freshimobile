//
//  LandingView.swift
//  Freshi
//
//  Created by Casey Roby on 4/21/21.
//
import SwiftUI
import Foundation


struct Landing: View {
    @EnvironmentObject var auth: Auth
    @State private var destination: String? = nil
    
    func printAuth(){
        print(auth.creds ?? "no creds")
    }
    
    func submit() {
        fetchAuthCreds(username: "", password:"", completionHandler: { authCreds, requestError in
            if let authCreds = authCreds {
                // If we have data, send it back to the main thread with DispatchQueue.
                DispatchQueue.main.async {
                    // Update the state and thereby our UI
                    auth.creds = authCreds
                }
                print(authCreds)
                
            }
            if let requestError = requestError {
                print(requestError)
            }
        })
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 0){
                Spacer(minLength: 30)
                // Header
                HStack{
                    Image("bar-logo")
                    .padding(.leading, GlobalStyles.padding)
                    Text("Freshi")
                    .foregroundColor(Color("highContrast"))
                    .fontWeight(.heavy)
                    .fontStyle(fontStyle: .title2)
                    Text("label")
                    .foregroundColor(Color("highContrast"))
                    .fontStyle(fontStyle: .title3)
                    // Spacer pushes everything to the other end of the view
                    Spacer()
                }
                // Image
                StretchyImage(imageName: "landing-collage")
                // Buttons
                VStack(alignment: .center, spacing: 4){
                    LogInNavButton()
                    SignUpNavButton()
                }
                .padding(.horizontal, GlobalStyles.padding)
                Spacer(minLength: 10)
                // Links
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5){
//                    NavigationLink(
//                        destination:
//                            TermsAndConditions()
//                            .navigationBarBackButtonHidden(true)
//                            .navigationBarHidden(true),
//                        tag: "t&c",
//                        selection: $destination){
//                            EmptyView()
//                        }
//                    NavigationLink(
//                        destination:
//                            PrivacyPolicy()
//                            .navigationBarBackButtonHidden(true)
//                            .navigationBarHidden(true),
//                        tag: "PrivacyPolicy",
//                        selection: $destination){
//                            EmptyView()
//                        }
//                    NavigationLink(
//                        destination:
//                            PasswordReset()
//                            .navigationBarBackButtonHidden(true)
//                            .navigationBarHidden(true),
//                        tag: "PasswordReset",
//                        selection: $destination){
//                            EmptyView()
//                        }
                    PrivacyNavLink()
                    Text("&")
                        .fontStyle(fontStyle: .callout)
                        .foregroundColor(Color("highContrast"))
                    Button("Terms"){
                        self.destination = "t&c"
                    }
                    .fontStyle(fontStyle: .callout)
                    .foregroundColor(Color("interactiveFocus"))
                    Image("dot")
                    Button(
                        action: {
                            self.destination = "PasswordReset"
                        },label: {
                            Text("Reset Password")
                        })
                    .fontStyle(fontStyle: .callout)
                    .foregroundColor(Color("interactiveFocus"))
                }
                Spacer(minLength: 10)
                Text("© freshi 2021")
                .fontStyle(fontStyle: .caption)
                .foregroundColor(Color("highContrast"))
                .padding(.vertical, 5)
            }
        }
        .navigationBarHidden(true)
    }
}
// strictly for dev previews in xcode.
struct Landing_Previews: PreviewProvider {
    static var previews: some View {
        Landing()
    }
}

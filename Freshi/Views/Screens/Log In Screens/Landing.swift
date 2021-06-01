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
                StretchyImage(imageName: "landing-collage")
                VStack(alignment: .center, spacing: 4){
                    NavigationLink(destination: LogIn(), tag: "LogIn", selection: $destination){
                        EmptyView()
                    }
                    .navigationBarHidden(true)
                    Button("Log in") {
                        self.destination = "LogIn"
                    }
                    .stretchyButton(state: StretchyButtonState.neutral)
                    
                    NavigationLink(destination: SignUp(), tag: "SignUp", selection: $destination){
                        EmptyView()
                    }
                    .navigationBarHidden(true)
                    Button("Create an account"){
                        self.destination = "SignUp"
                    }
                    .stretchyButton(state: StretchyButtonState.focused)
                }
                .padding(.horizontal, GlobalStyles.padding)
                Spacer(minLength: 10)
                HStack{
                    NavigationLink(destination: TermsAndConditions(), tag: "t&c", selection: $destination){
                        EmptyView()
                    }
                    .navigationBarHidden(true)
                    Button("Terms & Conditions"){
                        self.destination = "t&c"
                    }
                    .fontStyle(fontStyle: .callout)
                    .foregroundColor(Color("interactiveFocus"))
                    Image("dot")
                    NavigationLink(destination: PrivacyPolicy(), tag: "PrivacyPolicy", selection: $destination){
                        EmptyView()
                    }
                    Button("Privacy Policy"){
                        self.destination = "PrivacyPolicy"
                    }
                    .fontStyle(fontStyle: .callout)
                    .foregroundColor(Color("interactiveFocus"))
                }
                HStack {
                    NavigationLink(destination: PasswordReset(), tag: "PasswordReset", selection: $destination){
                        EmptyView()
                    }
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

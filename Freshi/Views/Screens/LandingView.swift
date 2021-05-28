//
//  LandingView.swift
//  Freshi
//
//  Created by Casey Roby on 4/21/21.
//
import SwiftUI
import Foundation


struct LandingView: View {
    @EnvironmentObject var auth: Auth
    
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
        Spacer()
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
        Image("landing-collage")
        Button(action: {
            print("Log in tapped!")
        }) {
            Text("Log in")
        }.focusedLargeButton()
        Button(action: {
            print("Create account tapped!")
        }) {
            Text("Create an account")
        }.neutralLargeButton()
        Spacer()
        HStack{
            Button("Terms & Conditions"){}
                .fontStyle(fontStyle: .callout)
                .foregroundColor(Color("interactiveFocus"))
            Text("-")
                .fontStyle(fontStyle: .callout)
                .foregroundColor(Color("highContrast"))
            Button("Reset Password"){}
                .fontStyle(fontStyle: .callout)
                .foregroundColor(Color("interactiveFocus"))
        }
        Spacer()
        Text("© freshi 2021")
            .fontStyle(fontStyle: .caption)
            .foregroundColor(Color("highContrast"))
            .padding(.vertical, 5)
    }
}
// strictly for dev previews in xcode.
struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

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
        HStack{
            Image("bar-logo")
                
            Text("Freshi")
                .font(.system(.title2, design: .rounded))
                .foregroundColor(Color("highContrast"))
                .fontWeight(.heavy)
            Text("label")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("highContrast"))
        }
        Image("landing-collage")
        Button("Fetch Auth") {
            self.submit()
        }
            .padding()
    }
    
}
// strictly for dev previews in xcode.
struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

//
//  ResetPWNavLink.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct ResetPWNavLink: View {
    @State private var selection: String? = nil
    var label: String
    
    var body: some View {
        VStack{
            // Conditionally render Nav Link to fix "Unable to present. Please file a bug." error.
            if selection == "PasswordReset" {
                NavigationLink(
                    destination:
                        PasswordReset()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    tag: "PasswordReset",
                    selection: $selection){
                        EmptyView()
                    }
            }
            Button(label){
                self.selection = "PasswordReset"
            }
            .fontStyle(fontStyle: .callout)
            .foregroundColor(Color("interactiveFocus"))
        }
    }
}
// strictly for dev previews in xcode.
struct ResetPWNavLink_Previews: PreviewProvider {
    static var previews: some View {
        ResetPWNavLink(label: "Reset Password")
    }
}

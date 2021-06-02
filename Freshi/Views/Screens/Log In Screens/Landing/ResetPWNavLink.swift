//
//  ResetPWNavLink.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct ResetPWNavLink: View {
    @State private var selection: String? = nil
    
    var body: some View {
        VStack{
            NavigationLink(
                destination:
                    PasswordReset()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true),
                tag: "PasswordReset",
                selection: $selection){
                    EmptyView()
                }
            Button("Reset Password"){
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
        ResetPWNavLink()
    }
}

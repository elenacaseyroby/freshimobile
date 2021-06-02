//
//  SignUpNavLink.swift
//  Freshi
//
//  Created by Casey Roby on 6/2/21.
//

import SwiftUI


struct SignUpNavLink: View {
    @State private var selection: String? = nil
    
    var body: some View {
        VStack{
            // Conditionally render Nav Link to fix "Unable to present. Please file a bug." error.
            if selection == "SignUp" {
                NavigationLink(
                    destination:
                        SignUp()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    tag: "SignUp",
                    selection: $selection){
                        EmptyView()
                    }
            }
            Button("Sign up"){
                self.selection = "SignUp"
            }
            .fontStyle(fontStyle: .callout)
            .foregroundColor(Color("interactiveFocus"))
        }
    }
}
// strictly for dev previews in xcode.
struct SignUpNavLink_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNavLink()
    }
}


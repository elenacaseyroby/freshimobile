//
//  PrivacyNavLink.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct PrivacyNavLink: View {
    @State private var selection: String? = nil
    
    var body: some View {
        VStack{
            // Conditionally render Nav Link to fix "Unable to present. Please file a bug." error.
            if selection == "PrivacyPolicy" {
                NavigationLink(
                    destination:
                        PrivacyPolicy()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    tag: "PrivacyPolicy",
                    selection: $selection){
                        EmptyView()
                    }
            }
            Button("Privacy"){
                self.selection = "PrivacyPolicy"
            }
            .fontStyle(fontStyle: .callout)
            .foregroundColor(Color("interactiveFocus"))
        }
    }
}
// strictly for dev previews in xcode.
struct PrivacyNavLink_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyNavLink()
    }
}

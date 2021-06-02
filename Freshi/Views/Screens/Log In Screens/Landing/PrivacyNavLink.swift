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
            NavigationLink(
                destination:
                    PrivacyPolicy()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true),
                tag: "PrivacyPolicy",
                selection: $selection){
                    EmptyView()
                }
            Button("Privacy Policy"){
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

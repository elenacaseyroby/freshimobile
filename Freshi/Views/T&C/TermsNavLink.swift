//
//  TermsNavLink.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct TermsNavLink: View {
    @State private var selection: String? = nil
    
    var body: some View {
        VStack{
            // Conditionally render Nav Link to fix "Unable to present. Please file a bug." error.
            if selection == "t&c" {
                NavigationLink(
                    destination:
                        TermsAndConditions()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    tag: "t&c",
                    selection: $selection){
                        EmptyView()
                    }
            }
            Button("Terms"){
                self.selection = "t&c"
            }
            .fontStyle(fontStyle: .callout)
            .foregroundColor(Color("interactiveFocus"))
        }
    }
}
// strictly for dev previews in xcode.
struct TermsNavLink_Previews: PreviewProvider {
    static var previews: some View {
        TermsNavLink()
    }
}

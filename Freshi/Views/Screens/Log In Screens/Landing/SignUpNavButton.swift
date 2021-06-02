//
//  SignUpNavButton.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct SignUpNavButton: View {
    @State private var selection: String? = nil
    
    var body: some View {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                // Conditionally render Nav Link to fix "Unable to present. Please file a bug." error.
                if selection == "SignUp" {
                    // Set navigation destination as SignUp view
                    NavigationLink(
                        destination:
                            SignUp()
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true),
                        tag: "SignUp",
                        selection: $selection){
                            EmptyView()
                        }
                    .navigationBarHidden(true)
                }
                // Set up button to trigger navigation link to LogIn view destination.
                Button("Sign Up"){
                    self.selection = "SignUp"
                }
                .stretchyButton(state: StretchyButtonState.focused)
            }
    }
}
// strictly for dev previews in xcode.
struct SignUpNavButton_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNavButton()
    }
}

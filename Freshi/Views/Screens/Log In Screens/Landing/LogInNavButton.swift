//
//  LogInNavButton.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct LogInNavButton: View {
    @State private var selection: String? = nil
    
    var body: some View {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                // Set navigation destination as LogIn view
                NavigationLink(
                    destination:
                        LogIn()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    tag: "LogIn",
                    selection: $selection){
                        EmptyView()
                    }
                .navigationBarHidden(true)
                // Set up button to trigger navigation link to LogIn view destination.
                Button("Log in"){
                    self.selection = "LogIn"
                }
                .stretchyButton(state: StretchyButtonState.neutral)
            }
    }
}
// strictly for dev previews in xcode.
struct LogInNavButton_Previews: PreviewProvider {
    static var previews: some View {
        LogInNavButton()
    }
}

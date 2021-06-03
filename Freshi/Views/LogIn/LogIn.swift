//
//  LogInView.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//
import SwiftUI


struct LogIn: View {
    @State var username: String = ""
    @State var usernameErrorMessage: String? = nil
    @State var usernameActive: Bool = false
    
    func usernameState(usernameActive: Bool) -> TextboxState {
        if usernameActive {
            return TextboxState.focused
        }
        return TextboxState.neutral
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(title: "Log in")
                Line()
            }
            // Textboxes
            TextField("Username", text: $username, onEditingChanged: { (editingChanged) in
                    if editingChanged {
                        self.usernameActive = true
                    } else {
                        self.usernameActive = false
                    }
                })
            .freshiTextbox(
//                state: usernameState(usernameActive: self.usernameActive),
//                errorMessage: self.usernameErrorMessage
                state: TextboxState.error,
                errorMessage: "blah"
            )
            
            // Links
            HStack(alignment: .center, spacing: 5){
                SignUpNavLink()
                Image("dot")
                ResetPWNavLink(label: "Forgot username or password?")
            }
            // Buttons
            HStack(alignment: .center, spacing: 10){
                Button("Log in") {
                    print("submit!")
                }
                .stretchyButton(state: StretchyButtonState.focused)
            }
            
            // Top align.
            Spacer()
        }
        .background(Color("background"))
        .padding(.leading, GlobalStyles.padding)
        .padding(.trailing, GlobalStyles.padding)
    }
}
// strictly for dev previews in xcode.
struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}


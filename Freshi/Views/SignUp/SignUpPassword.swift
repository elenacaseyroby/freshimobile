//
//  SignUpPassword.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import Foundation
import SwiftUI


struct SignUpPassword: View {
    // args
    @Binding var password: String
    @Binding var nextPressed: Bool
    @Binding var currentPage: Float
    
    // variables
    @State var secondPassword: String = ""
    
    @State var isActive: Bool = false
    @State var errorMessage: String? = nil
    @State var activeTextbox: ActiveTextbox = ActiveTextbox.none
    
    enum ActiveTextbox {
        case first, second, none
    }
    
    // func to decide state of textbox, ie which color border surrounds it.
    func textboxState(
        thisTextbox: ActiveTextbox,
        activeTextbox: ActiveTextbox,
        error: Bool
    ) -> TextboxState {
        if error {
            return TextboxState.error
        }
        if activeTextbox == thisTextbox {
            return TextboxState.focused
        }
        return TextboxState.neutral
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
            // Password label
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Choose a strong password")
                        .foregroundColor(Color("highContrast"))
                        .fontStyle(fontStyle: .headline)
                    Text("must be at least 8 characters")
                        .foregroundColor(Color("highContrast"))
                        .fontStyle(fontStyle: .subheadline)
                }
                Spacer()
            }
            // First password textbox
            SecureField("password", text: $password)
                .freshiPassword(
                    state: self.textboxState(
                        thisTextbox: ActiveTextbox.first,
                        activeTextbox: self.activeTextbox,
                        error: self.errorMessage != nil ? true : false
                    ),
                    onTap: {
                        self.activeTextbox = ActiveTextbox.first})
            // Second password textbox
            SecureField("password", text: $secondPassword)
                .freshiPassword(
                    state: self.textboxState(
                        thisTextbox: ActiveTextbox.second,
                        activeTextbox: self.activeTextbox,
                        error: self.errorMessage != nil ? true : false
                    ),
                    // Only show error message under second password
                    errorMessage: self.errorMessage,
                    onTap: {
                        self.activeTextbox = ActiveTextbox.second})
        }
        .onTapGesture {
            self.activeTextbox = ActiveTextbox.none
        }
        // If next is pressed, check for errors and move to next textbox.
        .onChange(of: nextPressed) { pressed in
            if pressed {
                // reset nextPressed
                self.nextPressed.toggle()
                // If passwords don't match, set error message.
                if self.password != self.secondPassword {
                    self.errorMessage = "Passwords must match"
                    return
                }
                // Check for errors
                let error = getPasswordError(password: self.password)
                // If error exists, show error and stay on page
                if error != nil {
                    self.errorMessage = error
                    return
                }
                // If no error, show next set of textboxes
                self.currentPage += 1
            }
        }
    }
}
// strictly for dev previews in xcode.
struct SignUpPassword_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPassword(
            password: .constant("password"),
            nextPressed: .constant(false),
            currentPage: .constant(1))
    }
}

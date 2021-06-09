//
//  SignUpUsername.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import SwiftUI


struct SignUpUsername: View {
    
    @Binding var username: String
    @Binding var nextButtonDisabled: Bool
    @Binding var nextPressed: Bool
    @Binding var currentPage: Float
    
    @State var isActive: Bool = false
    @State var errorMessage: String? = nil
    
    func textboxState(
        isActive: Bool,
        errorMessage: String? ) -> TextboxState {
        if errorMessage != nil {
            return TextboxState.error
        } else if isActive {
            return TextboxState.focused
        }
        return TextboxState.neutral
    }
    
    var body: some View {
        // Username textbox
        TextField("username", text: $username, onEditingChanged: {
            (editingChanged) in
            if editingChanged {
                self.isActive = true
            }
        })
            .freshiLogin(
                state: self.textboxState(
                    isActive: self.isActive,
                    errorMessage: self.errorMessage),
                errorMessage: self.errorMessage
            )
        .onAppear() {
            // disable next button until user has entered min num chars.
            if self.username.count < 3 {
                self.nextButtonDisabled = true
            }
        }
        .onChange(of: username) { newValue in
            // enable next button when user has entered min num chars.
            if newValue.count >= 3 {
                self.nextButtonDisabled = false
            }
        }
        // If next is pressed, check for errors and move to next textbox.
        .onChange(of: nextPressed) { pressed in
            if pressed {
                // Check for errors
                let error = getUsernameError(username: self.username)
                // If error exists, show error and stay on page
                if error != nil {
                    self.errorMessage = error
                    return
                }
                // If no error, show next set of textboxes
                self.currentPage += 1
                // reset nextPressed
                self.nextPressed.toggle()
            }
        }
    }
}
// strictly for dev previews in xcode.
struct SignUpUsername_Previews: PreviewProvider {
    static var previews: some View {
        SignUpUsername(
            username: .constant("ecroby"),
            nextButtonDisabled: .constant(true),
            nextPressed: .constant(false),
            currentPage: .constant(1))
    }
}


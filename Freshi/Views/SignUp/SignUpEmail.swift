//
//  SignUpEmail.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct SignUpEmail: View {
    // args
    @Binding var email: String
    @Binding var nextPressed: Bool
    @Binding var currentPage: Float
    
    // vars
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
        TextField("email", text: $email, onEditingChanged: {
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
        
        // If next is pressed, check for errors and move to next textbox.
        .onChange(of: nextPressed) { pressed in
            if pressed {
                // reset nextPressed
                self.nextPressed.toggle()
                // Check for errors
                let error = getEmailError(email: self.email)
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
struct SignUpEmail_Previews: PreviewProvider {
    static var previews: some View {
        SignUpEmail(
            email: .constant("ecroby@gmail.com"),
            nextPressed: .constant(false),
            currentPage: .constant(1))
    }
}


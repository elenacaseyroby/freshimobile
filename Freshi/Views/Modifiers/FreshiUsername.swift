//
//  UsernameTextbox.swift
//  Freshi
//
//  Created by Casey Roby on 6/7/21.
//

import SwiftUI


func getUsernameError(username: String) -> String? {
    if username.count == 0 {
        return "Please enter username."
    }
    if username.count < 3 {
        return "Username too short. Must be 3 - 16 characters in length."
    }
    if username.count > 16 {
        return "Username too long. Must be 3 - 16 characters in length."
    }
    return nil
}

struct FreshiUsername: ViewModifier {
    var state: TextboxState = TextboxState.neutral
    var errorMessage: String? = nil

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 5){
            // render textbox
            content
                .freshiTextbox(
                    state: self.state,
                    errorMessage: self.errorMessage
                )
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
    }
}

extension View {
    func freshiUsername(state: TextboxState = TextboxState.neutral, errorMessage: String? = nil) -> some View {
        self.modifier(FreshiUsername(state: state, errorMessage: errorMessage))
    }
}

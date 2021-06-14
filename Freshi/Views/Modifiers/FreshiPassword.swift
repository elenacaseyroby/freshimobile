//
//  FreshiPassword.swift
//  Freshi
//
//  Created by Casey Roby on 6/7/21.
//

import SwiftUI

func getPasswordError(password: String) -> String? {
    if password.count == 0 {
        return "Please enter password."
    }
    if password.count < 8 {
        return "Password too short. Must be 8 - 30 characters in length."
    }
    if password.count > 30 {
        return "Password too long. Must be 8 - 30 characters in length."
    }
    return nil
}

struct FreshiPassword: ViewModifier {
    var state: TextboxState = TextboxState.neutral
    var errorMessage: String? = nil
    var onTap: () -> Void

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 5){
            // render textbox
            content
                .freshiTextbox(
                    state: self.state,
                    errorMessage: self.errorMessage
                )
                .autocapitalization(.none)
                .onTapGesture {
                    self.onTap()
                }
        }
    }
}

extension View {
    func freshiPassword(
        state: TextboxState = TextboxState.neutral,
        errorMessage: String? = nil,
        onTap: @escaping () -> Void) -> some View {
        self.modifier(FreshiPassword(state: state, errorMessage: errorMessage, onTap: onTap))
    }
}


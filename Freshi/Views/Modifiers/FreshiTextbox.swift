//
//  FreshiTextbox.swift
//  Freshi
//
//  Created by Casey Roby on 6/2/21.
//

import SwiftUI

enum TextboxState {
    case neutral, focused, error
}

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

func getPasswordError(username: String) -> String? {
    if username.count == 0 {
        return "Please enter password."
    }
    if username.count < 6 {
        return "Password too short. Must be 6 - 30 characters in length."
    }
    if username.count > 30 {
        return "Password too long. Must be 6 - 30 characters in length."
    }
    return nil
}

struct FreshiTextbox: ViewModifier {
    var state: TextboxState = TextboxState.neutral
    var errorMessage: String? = nil
    
    func borderColor(state: TextboxState) -> String {
        if state == TextboxState.error {
            // if error message, border is red.
            return "error"
        } else if state == TextboxState.focused {
            // if in focus, highlight box.
            return "highlight"
        }
        // border blends with background.
        return "lowContrast"
    }

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 5){
            // render textbox
            content
                // dimensions
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    maxHeight: 21)
                .padding()
                // colors
                .background(Color("lowContrast"))
                .foregroundColor(Color("midContrast"))
                // rounded corner
                // need to make rounded shape to make the border line then crop the corner radius to make sure border is continuous :/
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 16)
                    .stroke(
                        Color(borderColor(state: self.state)),
                        lineWidth: 1.5)
                )
                .cornerRadius(16)
                // font
                .fontStyle(fontStyle: .body)
            
            // render error message
            if let errorMessage = self.errorMessage {
                FormErrorMessage(error: errorMessage)
            }
        }
    }
}

extension View {
    func freshiTextbox(state: TextboxState = TextboxState.neutral, errorMessage: String? = nil) -> some View {
        self.modifier(FreshiTextbox(state: state, errorMessage: errorMessage))
    }
}
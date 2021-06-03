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
                HStack(alignment: .center, spacing: 5){
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(Color("error"))
                    Text(errorMessage)
                        .foregroundColor(Color("error"))
                }
            }
        }
    }
}

extension View {
    func freshiTextbox(state: TextboxState, errorMessage: String) -> some View {
        self.modifier(FreshiTextbox(state: state, errorMessage: errorMessage))
    }
}

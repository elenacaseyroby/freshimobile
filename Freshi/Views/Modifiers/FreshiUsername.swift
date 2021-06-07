//
//  UsernameTextbox.swift
//  Freshi
//
//  Created by Casey Roby on 6/7/21.
//

import SwiftUI


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
                .autocapitalization(.none)
        }
    }
}

extension View {
    func freshiUsername(state: TextboxState = TextboxState.neutral, errorMessage: String? = nil) -> some View {
        self.modifier(FreshiUsername(state: state, errorMessage: errorMessage))
    }
}

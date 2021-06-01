//
//  StackingButtonStyles.swift
//  Freshi
//
//  Created by Casey Roby on 5/28/21.
//

import Foundation
import SwiftUI

enum StretchyButtonState {
    case neutral, focused, disabled
}

struct StretchyButton: ButtonStyle {
    var state: StretchyButtonState
    // Button is stretchy by default.
    var isSquare: Bool = false
    // Button height is always 35
    private let height: CGFloat = 35
    func backgroundColor (state: StretchyButtonState) -> String {
        switch state {
            case StretchyButtonState.disabled:
                return "lowContrast"
            case StretchyButtonState.focused:
                return "interactiveFocus"
            default:
                return "background"
        }
    }
    func foregroundColor (state: StretchyButtonState) -> String {
        switch state {
            case StretchyButtonState.disabled:
                return "midContrast"
            case StretchyButtonState.focused:
                return "background"
            default:
                return "interactiveFocus"
        }
    }
    func makeBody(configuration: Self.Configuration) -> some View {
            return configuration.label
                .frame(
                    minWidth: 0,
                    maxWidth: isSquare ? height : .infinity,
                    maxHeight: height)
                .padding()
                .foregroundColor(Color(foregroundColor(state: state)))
                .background(Color(backgroundColor(state: state)))
                .cornerRadius(15)
                .shadow(color: Color("shadow"), radius: 5)
                .fontStyle(fontStyle: .headline)
    }
}

// This allow us to call ViewModifiers and ButtonStyles straight up like other style modifiers.
extension View {
    func stretchyButton(state: StretchyButtonState, isSquare: Bool = false) -> some View {
        self.buttonStyle(StretchyButton(state: state, isSquare: isSquare))
    }
    
}


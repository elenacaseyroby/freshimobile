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
                // button dimensions
                .frame(
                    minWidth: 0,
                    maxWidth: isSquare ? height : .infinity,
                    maxHeight: height)
                .padding()
                // colors
                .foregroundColor(Color(foregroundColor(state: self.state)))
                .background(Color(backgroundColor(state: self.state)))
                // rounded corners
                .cornerRadius(15)
                // raised button look
                .shadow(color: Color("shadow"), radius: 5)
                // on press button effect
                .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
                .opacity(configuration.isPressed ? 0.9 : 1.0)
                // font
                .fontStyle(fontStyle: .headline)
    }
}

// This allow us to call ViewModifiers and ButtonStyles straight up like other style modifiers.
extension View {
    func stretchyButton(state: StretchyButtonState, isSquare: Bool = false) -> some View {
        self.buttonStyle(StretchyButton(state: state, isSquare: isSquare))
    }
    
}

// strictly for dev previews in xcode.
struct StretchyButton_Previews: PreviewProvider {
    static var previews: some View {
            VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            Button("Disabled Button") {
                // action
                print("can't trigger this action!")
            }
            // NOTE: you must include this for the button to stop being click-able
            .disabled(true)
            .stretchyButton(state: StretchyButtonState.disabled)
            Button("Focused Button") {
                // action
                print("focused button clicked!")
            }
            .stretchyButton(state: StretchyButtonState.focused)
            Button("Neutral Button") {
                // action
                print("neutral button clicked!")
            }
            .stretchyButton(state: StretchyButtonState.neutral)
            Button("+") {
                // action
                print("square buttpn clicked!")
            }
            .stretchyButton(
                state: StretchyButtonState.focused,
                isSquare: true)
        }
    }
}


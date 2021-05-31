//
//  StackingButtonStyles.swift
//  Freshi
//
//  Created by Casey Roby on 5/28/21.
//

import Foundation
import SwiftUI

// Can't make custom button styles that inherit from each other, so this had to be a ViewModifier.
struct StretchyButton: ViewModifier {
    let backgroundColor: String
    let foregroundColor: String
 
    func body(content: Content) -> some View {
    content
        .font(.system(.headline))
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 35)
        .padding()
        .foregroundColor(Color(foregroundColor))
        .background(Color(backgroundColor))
        .cornerRadius(15)
        .shadow(color: Color("shadow"), radius: 5)
    }
}

struct FocusedStretchyButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .stretchyButton(
                backgroundColor: "interactiveFocus",
                foregroundColor: "background")
            
    }
}

struct NeutralStretchyButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .stretchyButton(
                backgroundColor: "background",
                foregroundColor: "interactiveFocus")
            
            
    }
}

//struct StretchyButton: ButtonStyle {
//    let buttonState: String = 
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .stretchyButton(
//                backgroundColor: "background",
//                foregroundColor: "interactiveFocus")
//            
//            
//    }
//}

struct DisabledStretchyButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
                .font(.system(.headline))
                .frame(
                    minWidth: 0,
                    // .infinity makes this view stretch to fill space as needed.
                    maxWidth: .infinity,
                    minHeight: 35,
                    maxHeight: 35)
                .padding()
                .foregroundColor(Color("midContrast"))
                .opacity(0.5)
                .background(Color("lowContrast"))
                .cornerRadius(15)
    }
}

// This allow us to call ViewModifiers and ButtonStyles straight up like other style modifiers.
extension View {
    func stretchyButton(backgroundColor: String, foregroundColor: String) -> some View {
        self.modifier(StretchyButton(backgroundColor: backgroundColor, foregroundColor: foregroundColor))
    }
    func focusedStretchyButton() -> some View {
        self.buttonStyle(FocusedStretchyButton())
    }
    func neutralStretchyButton() -> some View {
        self.buttonStyle(NeutralStretchyButton())
    }
    func disabledStretchyButton() -> some View {
        self.modifier(DisabledStretchyButton())
    }
}


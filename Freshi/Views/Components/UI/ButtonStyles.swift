//
//  SmallFocusedButtonStyle.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//

import Foundation
import SwiftUI

// Can't make custom button styles that inherit from each other, so this had to be a ViewModifier.
struct LargeButton: ViewModifier {
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
        .padding(.horizontal, 25)
        .shadow(color: Color("shadow"), radius: 5)
    }
}

struct FocusedLargeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .largeButton(
                backgroundColor: "interactiveFocus",
                foregroundColor: "background")
            
    }
}

struct NeutralLargeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .largeButton(
                backgroundColor: "background",
                foregroundColor: "interactiveFocus")
            
            
    }
}

extension View {
//    func largeButton(backgroundColor: String, foregroundColor: String) -> some View {
//        self.buttonStyle(LargeButton(backgroundColor: backgroundColor, foregroundColor: foregroundColor))
//    }
    func largeButton(backgroundColor: String, foregroundColor: String) -> some View {
        self.modifier(LargeButton(backgroundColor: backgroundColor, foregroundColor: foregroundColor))
    }
    func focusedLargeButton() -> some View {
        self.buttonStyle(FocusedLargeButton())
    }
    func neutralLargeButton() -> some View {
        self.buttonStyle(NeutralLargeButton())
    }
}


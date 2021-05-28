//
//  HorizontalButtonStyle.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//

import Foundation
import SwiftUI

struct NeutralSquareButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline))
            .frame(minWidth: 35, maxWidth: 35, maxHeight: 35)
            .padding()
            .foregroundColor(Color("interactiveFocus"))
            .background(Color("background"))
            .cornerRadius(15)
            .shadow(color: Color("shadow"), radius: 5)
    }
}


// This allow us to call ViewModifiers and ButtonStyles straight up like other style modifiers.
extension View {
    func neutralSquareButton() -> some View {
        self.buttonStyle(NeutralSquareButton())
    }
}


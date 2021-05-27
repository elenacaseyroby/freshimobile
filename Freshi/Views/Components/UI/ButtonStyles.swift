//
//  SmallFocusedButtonStyle.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//

import Foundation
import SwiftUI


struct LargeButton: ButtonStyle {
    let backgroundColor: String
    let foregroundColor: String
 
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline))
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 35)
            .padding()
            .foregroundColor(Color(backgroundColor))
            .background(Color(foregroundColor))
            .cornerRadius(15)
            .padding(.horizontal, 10)
            .shadow(color: Color("shadow"), radius: 5)
    }
}
extension View {
    func largeButton(backgroundColor: String, foregroundColor: String) -> some View {
        self.buttonStyle(LargeButton(backgroundColor: backgroundColor, foregroundColor: foregroundColor))
    }
}


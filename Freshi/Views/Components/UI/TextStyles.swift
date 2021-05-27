//
//  TextStyles.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//

import Foundation
import SwiftUI

struct FontStyle: ViewModifier {
    let fontStyle: Font.TextStyle
 
  func body(content: Content) -> some View {
    content
        .font(.system(fontStyle, design: .rounded))
  }
}

// The extension allows us to use the modifier like this:
// .fontStyle()
// instead of like this:
// .modifier(FontStyle())
extension View {
    func fontStyle(fontStyle: Font.TextStyle) -> some View {
        self.modifier(FontStyle(fontStyle: fontStyle))
    }
}

//
//  Textbox.swift
//  Freshi
//
//  Created by Casey Roby on 6/2/21.
//

import SwiftUI


struct Textbox: View {
    // if this is passed thru then we highlight texbox as well.
    var errorMessage: String? = nil
    @State var username: String = ""
    @State var inFocus: Bool = false
    var body: some View {
        // Textboxes
        TextField("Username", text: $username, onEditingChanged: { (editingChanged) in
                if editingChanged {
                    self.inFocus = true
                } else {
                    self.inFocus = false
                }
            })
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
                    Color(self.inFocus ? "highlight" : "lowContrast"),
                    lineWidth: 1.5)
            )
            .cornerRadius(16)
            // font
            .fontStyle(fontStyle: .body)
    }
}

struct Textbox_Previews: PreviewProvider {
    static var previews: some View {
        Textbox()
    }
}

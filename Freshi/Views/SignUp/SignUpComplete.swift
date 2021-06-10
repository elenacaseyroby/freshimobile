//
//  SignUpComplete.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import SwiftUI

struct SignUpComplete: View {
    // State used to pop back one view
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("You’ve created a new account")
                        .foregroundColor(Color("highContrast"))
                        .fontStyle(fontStyle: .headline)
                    Text("Take a moment to finish setting up your profile")
                        .foregroundColor(Color("highContrast"))
                        .fontStyle(fontStyle: .subheadline)
                }
                Spacer()
            }
            StretchyImage(imageName: "landing-collage")
            // Buttons
            HStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
                    // Back Button
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("back-arrow")
                    }
                    .stretchyButton(
                        state: StretchyButtonState.neutral,
                        isSquare: true)
                    // Next Button & Nav
                    Button("Next"){
                        print("next")
                    }
                    // can't click button until enabled
                    .stretchyButton(
                        state: StretchyButtonState.neutral)
            }
        }
    }
}

struct SignUpComplete_Previews: PreviewProvider {
    static var previews: some View {
        SignUpComplete()
    }
}


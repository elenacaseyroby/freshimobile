//
//  LogInView.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//
import SwiftUI


struct LogIn: View {
    @State var isActive: Bool = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack{
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(title: "Log in")
                Line()
            }
            // Buttons
            HStack(alignment: .center, spacing: 10){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("back-arrow")
                }
                .stretchyButton(state: StretchyButtonState.neutral, isSquare: true)
                Button(action: {
                    print("Create account tapped!")
                }) {
                    Text("Create an account")
                }
                .stretchyButton(state: StretchyButtonState.focused)
                    
            }
            .padding(.leading, GlobalStyles.padding)
            .padding(.trailing, GlobalStyles.padding)
            // Top align.
            Spacer()
        }

    }
}
// strictly for dev previews in xcode.
struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}


//
//  LogInView.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//
import SwiftUI


struct LogIn: View {
    @State var isActive: Bool = true
    @State private var destination: String? = nil
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(title: "Log in")
                Line()
            }
            ResetPWNavLink(label: "Forgot username or password?")
            // Buttons
            HStack(alignment: .center, spacing: 10){
                Button("Log in") {
                    print("submit!")
                }
                .stretchyButton(state: StretchyButtonState.focused)
            }
            .padding(.leading, GlobalStyles.padding)
            .padding(.trailing, GlobalStyles.padding)
            // Top align.
            Spacer()
        }
        .background(Color("background"))
    }
}
// strictly for dev previews in xcode.
struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}


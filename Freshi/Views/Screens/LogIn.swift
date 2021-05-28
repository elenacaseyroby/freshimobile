//
//  LogInView.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//
import SwiftUI
import Foundation


struct LogIn: View {
    var body: some View {
        VStack{
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(title: "Log in")
                Line()
            }
            HStack(alignment: .center, spacing: 10){
                Button(action: {
                    print("Log in tapped!")
                }) {
                    Text("Log in")
                }
                    .neutralSquareButton()
                Button(action: {
                    print("Create account tapped!")
                }) {
                    Text("Create an account")
                }
                    .disabledStretchyButton()
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


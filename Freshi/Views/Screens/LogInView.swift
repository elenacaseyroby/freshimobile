//
//  LogInView.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//
import SwiftUI
import Foundation


struct LogInView: View {
    var body: some View {
        HStack (alignment: .center, spacing: 10){
            Button(action: {
                print("Log in tapped!")
            }) {
                Text("Log in")
                }.neutralHorizontalButton()
                
            
            Button(action: {
                print("Create account tapped!")
            }) {
                Text("Create an account")
            }.focusedHorizontalButton()
        }
        .padding(GlobalStyles.padding)
    }
}
// strictly for dev previews in xcode.
struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}


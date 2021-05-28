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
        VStack{
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
        }
    }
}
// strictly for dev previews in xcode.
struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}


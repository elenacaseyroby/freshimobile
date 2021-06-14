//
//  Header.swift
//  Freshi
//
//  Created by Casey Roby on 5/28/21.
//

import SwiftUI

struct Header: View {
    let title: String
    var onExit: () -> Void
    var body: some View {
        HStack{
            // logo
            Image("bar-logo")
            // title
            Text(title)
                .foregroundColor(Color("highContrast"))
                .fontWeight(.semibold)
                .fontStyle(fontStyle: .title3)
            // .right aligned exit icon
            Spacer()
            Button(action: {
                self.onExit()
            }) {
                Image("exit-icon")
            }
        }
        .padding(.top, 15)
        .padding(.bottom, 10)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(
            title: "Log in",
            onExit: {
                print("exited")})
    }
}

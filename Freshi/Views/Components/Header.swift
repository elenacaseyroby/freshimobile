//
//  Header.swift
//  Freshi
//
//  Created by Casey Roby on 5/28/21.
//

import SwiftUI

struct Header: View {
    let title: String
    var body: some View {
        HStack{
            Image("bar-logo")
            Text(title)
                .foregroundColor(Color("highContrast"))
                .fontWeight(.semibold)
                .fontStyle(fontStyle: .title3)
            Spacer()
            Button(action: {
                print("Exit tapped!")
            }) {
                Text("X")
            }
        }
        .padding(.leading, GlobalStyles.padding)
        .padding(.trailing, GlobalStyles.padding)
        .padding(.top, 15)
        .padding(.bottom, 10)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(title: "Log in")
    }
}

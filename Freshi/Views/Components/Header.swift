//
//  Header.swift
//  Freshi
//
//  Created by Casey Roby on 5/28/21.
//

import SwiftUI

struct Header: View {
    @Environment(\.presentationMode) var presentationMode
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
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image("exit-icon")
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

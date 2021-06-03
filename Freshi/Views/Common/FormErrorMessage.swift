//
//  FormErrorMessage.swift
//  Freshi
//
//  Created by Casey Roby on 6/3/21.
//

import SwiftUI

struct FormErrorMessage: View {
    let error: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 5){
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(Color("error"))
                Text(self.error)
                    .foregroundColor(Color("error"))
                // left align
                Spacer()
            }
        }
    }
}

struct FormErrorMessage_Previews: PreviewProvider {
    static var previews: some View {
        FormErrorMessage(error: "error: must do x")
    }
}

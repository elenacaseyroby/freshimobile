//
//  TermsAndConditions.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct TermsAndConditions: View {
    @Binding var selection: String
    var selectionOnExit: String
    var body: some View {
        Button("exit") {
            self.selection = selectionOnExit
        }
        Text("Terms and conditions!")
    }
}
// strictly for dev previews in xcode.
struct TermsAndConditions_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditions(
            selection: .constant("landing"),
            selectionOnExit: "landing")
    }
}

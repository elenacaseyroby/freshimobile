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
    @State var menuSelection: String = "Terms & Conditions"
    
    let urls: [String: String] = [
        "Terms & Conditions": "http://localhost:3000/mobile-terms-and-conditions",
        "Privacy Policy": "http://localhost:3000/mobile-privacy-policy",
    ]
    
    var body: some View {
        VStack {
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10){
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                    Header(
                        title: self.menuSelection,
                        onExit: {
                            withAnimation {
                                self.selection = selectionOnExit
                            }
                        })
                    Line()
                }
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                    // Buttons
                    Button("Terms") {
                        self.menuSelection = "Terms & Conditions"
                    }
                    .stretchyButton(state: (
                        self.menuSelection == "Terms & Conditions" ?
                        StretchyButtonState.focused :
                        StretchyButtonState.neutral))
                    // Buttons
                    Button("Privacy Policy") {
                        self.menuSelection = "Privacy Policy"
                    }
                    .stretchyButton(state: (
                        self.menuSelection == "Privacy Policy" ?
                        StretchyButtonState.focused :
                        StretchyButtonState.neutral))
                }
            }
            .padding(.leading, GlobalStyles.padding)
            .padding(.trailing, GlobalStyles.padding)
            WebView(url: urls[self.menuSelection]!)
        }
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

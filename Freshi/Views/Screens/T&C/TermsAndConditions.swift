//
//  TermsAndConditions.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI
import WebKit


struct TermsAndConditions: View {
    @EnvironmentObject var privacyPolicyStore: PrivacyPolicyStore
    @Binding var selection: String
    var selectionOnExit: String
    @State var menuSelection: String = "Terms & Conditions"
    
    var tchtml: String = """
        <h2>Termsss</h2>
    """
    
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
            if menuSelection == "Privacy Policy" {
                HTMLView(htmlContent: privacyPolicyStore.body)
            }
            if menuSelection == "Terms & Conditions" {
                HTMLView(htmlContent: tchtml)
            }
        }
        .padding(.leading, GlobalStyles.padding)
        .padding(.trailing, GlobalStyles.padding)
        .background(Color("background"))
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

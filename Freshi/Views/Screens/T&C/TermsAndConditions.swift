//
//  TermsAndConditions.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI
import WebKit


struct TermsAndConditions: View {
    @Binding var selection: String
    var selectionOnExit: String
    @State var menuSelection: String = "Terms & Conditions"
    
    var tchtml: String = """
        <h2>Termsss</h2>
    """
    var pphtml: String = """
        <h1>END USER LICENSE AGREEMENT</h1>
            <h3>Last updated February 10, 2021</h3>
            
            <p>
            Freshi is licensed to You (End-User) by Freshi, located at 515 Decatur Street Apt 2F, Brooklyn, New York 11233, United States (hereinafter: Licensor), for use only under the terms of this License Agreement.
            
            By downloading the Application from the Apple AppStore, and any update thereto (as permitted by this License Agreement), You indicate that You agree to be bound by all of the terms and conditions of this License Agreement, and that You accept this License Agreement.
            
            The parties of this License Agreement acknowledge that Apple is not a Party to this License Agreement and is not bound by any provisions or obligations with regard to the Application, such as warranty, liability, maintenance and support thereof. Freshi, not Apple, is solely responsible for the licensed Application and the content thereof.
            
            This License Agreement may not provide for usage rules for the Application that are in conflict with the latest App Store Terms of Service. Freshi acknowledges that it had the opportunity to review said terms and this License Agreement is not conflicting with them.
            
            All rights not expressly granted to You are reserved.
            </p>
            
            <h2>1. THE APPLICATION</h2>
            <p>
            Freshi (hereinafter: Application) is a piece of software created to provide a social media for food lovers to contribute, share, and distribute, and disseminate recipes, guidelines, dietary information, meal photos et all, and to empower users to better understand and educate
            </p>
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
                HTMLView(htmlContent: pphtml)
            }
            if menuSelection == "Terms & Conditions" {
                HTMLView(htmlContent: tchtml)
            }
        }
        .padding(.leading, GlobalStyles.padding)
        .padding(.trailing, GlobalStyles.padding)
        .preferredColorScheme(.light)
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

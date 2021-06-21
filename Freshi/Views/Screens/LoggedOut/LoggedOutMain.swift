//
//  LoggedOutMain.swift
//  Freshi
//
//  Created by Casey Roby on 6/20/21.
//

import SwiftUI


struct LoggedOutMain: View {
    @State var selection: String = ""
    @State var url: URL? = nil
    
    var body: some View {
        VStack {
            switch self.selection {
            case "landing":
                Landing(selection: $selection)
            case "log-in":
                LogIn(selection: $selection)
                    .transition(.move(edge: .bottom))
            case "sign-up":
                SignUp(selection: $selection)
                    .transition(.move(edge: .bottom))
            case "request-password-reset":
                RequestPasswordReset(selection: $selection)
                    .transition(.move(edge: .bottom))
            case "reset-password":
                ResetPassword(
                    selection: $selection,
                    url: self.url)
                    .transition(.move(edge: .bottom))
            case "t&c":
                TermsAndConditions(
                    selection: $selection,
                    selectionOnExit: "landing")
                    .transition(.move(edge: .bottom))
            default:
                Landing(selection: $selection)
            }
        }
        .onOpenURL { url in
            self.url = url
            self.selection = url.lastPathComponent
        }
    }
}
// strictly for dev previews in xcode.
struct LoggedOutMain_Previews: PreviewProvider {
    static var previews: some View {
        LoggedOutMain()
    }
}

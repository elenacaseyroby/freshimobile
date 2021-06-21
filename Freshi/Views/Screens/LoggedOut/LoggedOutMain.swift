//
//  LoggedOutMain.swift
//  Freshi
//
//  Created by Casey Roby on 6/20/21.
//

import SwiftUI


struct LoggedOutMain: View {
    @State var selection: String = ""
    
    var body: some View {
        VStack {
            switch self.selection {
            case "landing":
                Landing(selection: $selection)
            case "log-in":
                LogIn(selection: $selection)
            case "sign-up":
                SignUp(selection: $selection)
            case "request-passord-reset":
                RequestPasswordReset(selection: $selection)
            case "reset-password":
                ResetPassword(selection: $selection)
            case "t&c":
                TermsAndConditions(
                    selection: $selection,
                    selectionOnExit: "landing")
                    .transition(.move(edge: .bottom))
            default:
                Landing(selection: $selection)
                    .transition(.move(edge: .top))
            }
        }
        .onOpenURL { url in
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

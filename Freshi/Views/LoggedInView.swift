//
//  LoggedInView.swift
//  Freshi
//
//  Created by Casey Roby on 5/31/21.
//

import SwiftUI

struct LoggedInView: View {
    // authentication state for app
    @EnvironmentObject var auth: Auth
    var body: some View {
        Button("log out") {
            logOutAction(auth: auth)
        }
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView()
    }
}

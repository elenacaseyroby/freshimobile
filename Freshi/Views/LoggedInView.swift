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
        Button("Log out") {
            auth.logOut()
        }
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView()
    }
}

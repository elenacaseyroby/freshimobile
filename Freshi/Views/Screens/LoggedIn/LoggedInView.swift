//
//  LoggedInView.swift
//  Freshi
//
//  Created by Casey Roby on 5/31/21.
//

import SwiftUI

struct LoggedInView: View {
    // authentication state for app
    @EnvironmentObject var authStore: AuthStore
    var body: some View {
        Button("log out") {
            logOutAction(authStore: authStore)
        }
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView()
    }
}

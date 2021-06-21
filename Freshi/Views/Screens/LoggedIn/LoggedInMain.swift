//
//  LoggedInView.swift
//  Freshi
//
//  Created by Casey Roby on 5/31/21.
//

import SwiftUI

struct LoggedInMain: View {
    // Manages overlays and screen redirects.
    @EnvironmentObject var screenManagerStore: ScreenManagerStore
    
    func showSignUpCompletedScreen() -> Bool {
        return self.screenManagerStore.showSignUpCompletedScreen
    }
    // authentication state for app
    @EnvironmentObject var authStore: AuthStore
    var body: some View {
        if showSignUpCompletedScreen() {
            SignUpComplete()
        } else {
            Button("log out") {
                logOutAction(authStore: authStore)
            }
        }
    }
}

struct LoggedInMain_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInMain()
    }
}

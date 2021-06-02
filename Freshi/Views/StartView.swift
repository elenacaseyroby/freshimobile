//
//  StartView.swift
//  Freshi
//
//  Created by Casey Roby on 5/31/21.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var auth: Auth
    
    var body: some View {
        // If creds in state, show logged in view.
        if auth.creds != nil {
            LoggedInView()
        // If no creds, show logged out view.
        } else {
            Landing()
                // pass our order state into our Main view.
                .environmentObject(auth)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}



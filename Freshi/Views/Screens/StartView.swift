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
        if auth.creds != nil {
            LoggedInView()
                
        } else {
            LoggedOutView()
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



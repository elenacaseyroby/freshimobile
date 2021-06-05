//
//  LoadingOverlay.swift
//  Freshi
//
//  Created by Casey Roby on 6/4/21.
//

import SwiftUI

struct LoadingOverlay: View {
        
    var body: some View {
        ZStack {
            Rectangle()
                .background(Color("midContrast"))
                .opacity(0.3)
            CircleLoader(
                backgroundColor: Color("highContrast"),
                foregroundColor: Color("interactiveFocus"))
            
        }
        
    }
}

struct LoadingOverlay_Previews: PreviewProvider {
    static var previews: some View {
        LoadingOverlay()
    }
}

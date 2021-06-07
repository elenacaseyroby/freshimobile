//
//  LandingHeader.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct LandingHeader: View {
    var body: some View {
        HStack{
            Image("bar-logo")
            Text("Freshi")
            .foregroundColor(Color("highContrast"))
            .fontWeight(.heavy)
            .fontStyle(fontStyle: .title2)
            Text("meals are for sharing")
            .foregroundColor(Color("highContrast"))
            .fontStyle(fontStyle: .title3)
            // Spacer pushes everything to the other end of the view
            Spacer()
        }
    }
}
// strictly for dev previews in xcode.
struct LandingHeader_Previews: PreviewProvider {
    static var previews: some View {
        LandingHeader()
    }
}

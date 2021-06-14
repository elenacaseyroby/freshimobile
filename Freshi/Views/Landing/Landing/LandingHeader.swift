//
//  LandingHeader.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//

import SwiftUI


struct LandingHeader: View {
    var body: some View {
        HStack(alignment: .center){
            // logo
            Image("bar-logo")
            HStack(alignment: .bottom, spacing: 5) {
                // title
                Text("Freshi")
                    .foregroundColor(Color("highContrast"))
                    .fontWeight(.semibold)
                    .fontStyle(fontStyle: .title2)
                // subtitle
                Text("meals are for sharing")
                    .foregroundColor(Color("highContrast"))
                    .fontStyle(fontStyle: .title3)
                // .right aligned exit icon
                }
            Spacer()
        }
        .padding(.top, 20)
        .padding(.bottom, 0)
    }
}
// strictly for dev previews in xcode.
struct LandingHeader_Previews: PreviewProvider {
    static var previews: some View {
        LandingHeader()
    }
}

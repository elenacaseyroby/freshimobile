//
//  LandingView.swift
//  Freshi
//
//  Created by Casey Roby on 4/21/21.
//
import SwiftUI
import Foundation

struct LandingView: View {
    
    var body: some View {
        HStack{
            Image("bar-logo")
                
            Text("Freshi")
                .font(.system(.title2, design: .rounded))
                .foregroundColor(Color("highContrast"))
                .fontWeight(.heavy)
            Text("label")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("highContrast"))
        }
        Image("landing-collage")
    }
    
}
// strictly for dev previews in xcode.
struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

//
//  LoadingDots.swift
//  Freshi
//
//  Created by Casey Roby on 6/4/21.
//

import SwiftUI

struct LoadingDots: View {
    var color: Color
    var width: CGFloat = 80
    
    // varibales
    var diameter: CGFloat = 15
    var bounceSpeed: Double = 0.5
    
    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: self.width/5){
            Circle()
                .fill(self.color)
                .frame(width: self.diameter, height: self.diameter)
                .animation(Animation.easeInOut(duration: self.bounceSpeed).repeatForever())
            Circle()
                .fill(self.color)
                .frame(width: self.diameter, height: self.diameter)
                .animation(Animation.easeInOut(duration: self.bounceSpeed).repeatForever().delay(0.3))
            Circle()
                .fill(self.color)
                .frame(width: self.diameter, height: self.diameter)
                .animation(Animation.easeInOut(duration: self.bounceSpeed).repeatForever().delay(0.5))
        }
        .frame(minWidth: 150)
        .padding(.top, 20)
    }
}

struct LoadingDots_Previews: PreviewProvider {
    static var previews: some View {
        LoadingDots(color: Color("midContrast"))
    }
}

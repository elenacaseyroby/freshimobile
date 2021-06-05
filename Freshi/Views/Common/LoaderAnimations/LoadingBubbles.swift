//
//  LoadingDots2.swift
//  Freshi
//
//  Created by Casey Roby on 6/4/21.
//

import SwiftUI

struct LoadingBubbles: View {
    var color: Color
    var width: CGFloat = 80
    
    // variabales
    var diameter: CGFloat = 25
    var bounceSpeed: Double = 0.5
    
    @State private var animate = false
    
    var body: some View {
        HStack {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: self.width/5){
                Circle()
                    .fill(self.color)
                    .frame(width: self.diameter, height: self.diameter)
                    .scaleEffect(self.animate ? 0.0 : 1.0)
                    .animation(Animation.easeInOut(
                        duration: self.bounceSpeed).repeatForever())
                Circle()
                    .fill(self.color)
                    .frame(width: self.diameter, height: self.diameter)
                    .scaleEffect(self.animate ? 0.0 : 1.0)
                    .animation(Animation.easeInOut(
                        duration: self.bounceSpeed).repeatForever().delay(0.3))
                Circle()
                    .fill(self.color)
                    .frame(width: self.diameter, height: self.diameter)
                    .scaleEffect(self.animate ? 0.0 : 1.0)
                    .animation(Animation.easeInOut(
                        duration: self.bounceSpeed).repeatForever().delay(0.6))
            }
            .onAppear {
                self.animate = true
            }
        }
    }
}

struct LoadingBubbles_Previews: PreviewProvider {
    static var previews: some View {
        LoadingBubbles(color: Color("midContrast"))
    }
}

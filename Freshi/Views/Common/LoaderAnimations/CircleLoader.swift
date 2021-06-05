//
//  CircleLoader.swift
//  Freshi
//
//  Created by Casey Roby on 6/4/21.
//

import SwiftUI

struct CircleLoader: View {
    var backgroundColor: Color
    var foregroundColor: Color
    
    // variables
    let strokeWidth: CGFloat = 10
    let circleDiameter: CGFloat = 30
    let trackerRotation: Double = 2
    let animationDuration: Double = 0.75
    
    @State var isAnimating: Bool = false
    @State var circleStart: CGFloat = 0.17
    @State var circleEnd: CGFloat = 0.325
    
    @State var rotationDegree: Angle = Angle.degrees(0)
    
     // views
    var body: some View {
       ZStack {
            Circle()
                .stroke(
                    style: StrokeStyle(
                        lineWidth: self.strokeWidth))
                .fill(self.backgroundColor)
            Circle()
                .trim(
                    from: circleStart,
                    to: circleEnd)
                .stroke(style: StrokeStyle(
                            lineWidth: self.strokeWidth,
                            lineCap: .round))
                .fill(self.foregroundColor)
                .rotationEffect(self.rotationDegree)
       }.frame(
            width: self.circleDiameter,
            height: self.circleDiameter)
        .onAppear() {
            self.animateLoader()
            Timer.scheduledTimer(
                withTimeInterval: self.trackerRotation * self.animationDuration + (self.animationDuration),
                repeats: true) {
                (mainTimer) in
                self.animateLoader()
            }
        }
    }
    
    // functions
    func getRotationAngle() -> Angle {
        return .degrees(360 * self.trackerRotation) + .degrees(120)
    }
    
    func animateLoader() {
        withAnimation(Animation.spring(response: animationDuration * 2 )) {
            self.rotationDegree = .degrees(-57.5)
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: self.trackerRotation * self.animationDuration)) {
                self.rotationDegree += self.getRotationAngle()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration * 1.25, repeats: false) { _ in
            withAnimation(Animation.easeOut(duration: (self.trackerRotation * self.animationDuration) / 2.25 )) {
                self.circleEnd = 0.925
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: trackerRotation * animationDuration, repeats: false) { _ in
            self.rotationDegree = .degrees(47.5)
            withAnimation(Animation.easeOut(duration: self.animationDuration)) {
                self.circleEnd = 0.325
            }
        }
    }
}

struct CircleLoader_Previews: PreviewProvider {
    static var previews: some View {
        CircleLoader(
            backgroundColor: Color("highContrast"),
            foregroundColor: Color("interactiveFocus"))
    }
}


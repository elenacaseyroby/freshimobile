//
//  LoadingSpinner.swift
//  Freshi
//
//  Created by Casey Roby on 6/4/21.
//

import SwiftUI

struct LoadingSpinner: View {
    var backgroundColor: Color
    var foregroundColor: Color
    
    private let rotationTime: Double = 0.75
    private let fullRotation: Angle = .degrees(360)
    private let animationTime: Double = 1.9
    private static let initialDegree: Angle = .degrees(270)
    
    @State var spinnerStart: CGFloat = 0.0
    @State var spinnerEndS1: CGFloat = 0.03
    @State var rotationDegreeS1 = initialDegree
    
    func animateSpinner(with timeInterval: Double, completion: @escaping (() -> Void)) {
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: rotationTime)) {
                completion()
            }
        }
    }
    
    var body: some View {
        ZStack {
            BackgroundCircle(
                color: self.backgroundColor)
            SpinnerCircle(
                start: spinnerStart,
                end: spinnerEndS1,
                rotation: rotationDegreeS1,
                color: foregroundColor)
        }
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { (mainTimer) in
                self.animateSpinner(with: rotationTime) { self.spinnerEndS1 = 1.0 }
            }
        }
    }
}

struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: self.start, to: self.end)
                .stroke(self.color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
        }
        .frame(width: 30, height: 30)
    }
}

struct BackgroundCircle: View {
    var color: Color
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 50, height: 50)
    }
}

struct LoadingSpinner_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSpinner(
            backgroundColor: Color("highContrast"),
            foregroundColor: Color("interactiveFocus"))
    }
}

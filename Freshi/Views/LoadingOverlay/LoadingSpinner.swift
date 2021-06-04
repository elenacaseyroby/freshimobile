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
    private let animationSpeed: Double = 0.03
    
    @State var spinnerAngle: Int = 0
    
    func moveSpinner() {
        self.spinnerAngle = (self.spinnerAngle + 10) % 360
    }

    var body: some View {
        ZStack {
            BackgroundCircle(
                color: self.backgroundColor)
            SpinnerCircle(
                color: foregroundColor,
                angle: self.spinnerAngle)
        }
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: animationSpeed, repeats: true) {
                (mainTimer) in
                self.moveSpinner()
            }
        }
    }
}

struct SpinnerCircle: View {
    var color: Color
    // between 0 and 360
    var angle: Int
    
    func adjustedDegrees(degrees: Int) -> Double {
        // adjusted to start at top of circle
        return Double(degrees - 90)
    }
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0.0, to: 0.2)
                .stroke(self.color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(
                    .degrees(
                        adjustedDegrees(
                            degrees: self.angle)))
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

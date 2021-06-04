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
    
    @State var spinnerAngle: Int = 0
    @State var animationsOn = true
    
    // every: dictates animation speed. closer to 0 is faster, closer to 1 is slower.
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    
    func moveSpinner() {
        let numberBtwn0and180: Double = Double(self.spinnerAngle / 2)
        var numberBtwn0and1: Double = sin(numberBtwn0and180)
        if numberBtwn0and1 == 0.0 {
            numberBtwn0and1 = sin(numberBtwn0and180 + 3)
        }
        let increment: Int = Int(1 + (20 * abs(numberBtwn0and1)))
        self.spinnerAngle = (self.spinnerAngle + increment) % 360
    }

    var body: some View {
        ZStack {
            BackgroundCircle(
                color: self.backgroundColor)
            SpinnerCircle(
                color: foregroundColor,
                angle: self.spinnerAngle)
        }
        .onReceive(timer) { _ in
            // do this everytime timer is published.
            self.moveSpinner()
        }
        .onDisappear() {
            // stop timer on screen close:
            self.timer.upstream.connect().cancel()
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

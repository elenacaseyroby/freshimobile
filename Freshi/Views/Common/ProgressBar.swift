//
//  HeaderProgressBar.swift
//  Freshi
//
//  Created by Casey Roby on 6/7/21.
//

import SwiftUI

struct ProgressBar: View {
    var fromPercent: CGFloat = 0.0
    var toPercent: CGFloat
    
    // variables
    var height: CGFloat = 5
    var backgroundColor: Color = Color("lowContrast")
    var color: Color = Color("interactiveFocus")
    
    
    
    @State var animate: Bool = false
    
    var body: some View {
        // We use geometry reader to adjust to the width of the screen.
        GeometryReader { geo in
            ZStack {
                // background line
                Rectangle()
                    .fill(self.backgroundColor)
                    .frame(
                        width: geo.size.width,
                        height: self.height
                    )
                // progress line
                HStack {
                    Rectangle()
                        .fill(self.color)
                        // Animates the line from the previous percentage to the current percentage.
                        .frame(
                            width: self.animate ? (geo.size.width * self.toPercent) : (geo.size.width * self.fromPercent),
                            height: self.height
                        )
                    // left align
                    Spacer()
                }
            }
            .cornerRadius(15)
            .onAppear(perform: {
                // Specify how to animate to transition between states.
                withAnimation(.spring(response: 0.7 )) {
                    self.animate = true
                }
            })
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(
            fromPercent: 0.1,
            toPercent: 0.9)
    }
}

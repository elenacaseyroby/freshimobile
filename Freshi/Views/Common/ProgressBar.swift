//
//  HeaderProgressBar.swift
//  Freshi
//
//  Created by Casey Roby on 6/7/21.
//

import SwiftUI

struct ProgressBar: View {
    // only animates on first load. gotta figure out how to fix..
    var prevPage: Float? = nil
    @Binding var currentPage: Float
    let totalPages: Float
    

    @State var fromPercent: CGFloat = 0.0
    @State var toPercent: CGFloat = 0.0
    
    // variables
    var height: CGFloat = 5
    var backgroundColor: Color = Color("lowContrast")
    var color: Color = Color("interactiveFocus")
    
    @State var animate: Bool = false
    
    func setAnimationInstructions(prevPage: Float, currentPage: Float) {
        self.animate = false
        // Specify how to animate to transition between states.
        withAnimation(.spring(response: 0.7 )) {
            self.fromPercent = CGFloat(
                percentAsDecimal(
                    value: prevPage,
                    total: self.totalPages))
            self.toPercent = CGFloat(
                percentAsDecimal(
                    value: currentPage,
                    total: self.totalPages))
            self.animate = true
        }
    }
    
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
                        .frame(
                            // Animates the line from the previous percentage to the current percentage.
                            width: self.animate ? (geo.size.width * self.toPercent) : (geo.size.width * self.fromPercent),
                            height: self.height
                        )
                    // if it gets near 100%, remove spacer so it reaches the full width
                    if self.toPercent < 0.95 {
                        Spacer()
                    }
                }
            }
            .cornerRadius(15)
            .onAppear(perform: {
                var animateFromPage: Float = 0.0
                if let prevPage = prevPage {
                    animateFromPage = prevPage
                }
                self.setAnimationInstructions(prevPage: animateFromPage, currentPage: self.currentPage)
            })
            .onChange(of: currentPage, perform: { [currentPage] nextPage in
                self.setAnimationInstructions(prevPage: currentPage, currentPage: nextPage)
            })
        }
        // Need this, to keep the progress bar from distorting the view layout whereever it's used.
        .frame(
            height: self.height
        )
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(
            currentPage: .constant(1.0),
            totalPages: 4.0)
    }
}

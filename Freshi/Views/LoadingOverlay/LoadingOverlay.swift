//
//  LoadingOverlay.swift
//  Freshi
//
//  Created by Casey Roby on 6/4/21.
//

import SwiftUI

enum LoaderAnimation {
    case circle, bubbles, dots
}

struct LoadingOverlay: View {
    var animation: LoaderAnimation = LoaderAnimation.circle
    var isLoading: Bool = false
    
        
    var body: some View {
        ZStack {
            if self.isLoading {
                Rectangle()
                    .background(Color("midContrast"))
                    .opacity(0.3)
                if self.animation == LoaderAnimation.circle {
                    CircleLoader(
                        backgroundColor: Color("highContrast"),
                        foregroundColor: Color("interactiveFocus"))
                } else if self.animation == LoaderAnimation.bubbles {
                    LoadingBubbles(color: Color("highContrast"))
                } else {
                    LoadingDots(color: Color("highContrast"))
                }
            }
        }
    }
}

struct LoadingOverlay_Previews: PreviewProvider {
    static var previews: some View {
        LoadingOverlay()
    }
}

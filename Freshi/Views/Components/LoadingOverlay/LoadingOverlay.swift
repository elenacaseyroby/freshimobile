//
//  LoadingOverlay.swift
//  Freshi
//
//  Created by Casey Roby on 6/4/21.
//

import SwiftUI

enum LoaderAnimation {
    case circle, bubbles
}

struct LoadingOverlay: View {
    var animation: LoaderAnimation = LoaderAnimation.bubbles
    var isLoading: Bool = false
    
        
    var body: some View {
        ZStack {
            if self.isLoading {
                Rectangle()
                    .background(Color("lowContrast"))
                    .opacity(0.15)
                ZStack {
                    // circle loader or bubbles based on arguments.
                    if self.animation == LoaderAnimation.circle {
                        CircleLoader(
                            backgroundColor: Color("midContrast"),
                            foregroundColor: Color("background"))
                    }  else {
                        LoadingBubbles(color: Color("background"))
                    }
                }
                .padding(20)
//                .frame(width: 120, height: 120)
                .background(Color("highContrast"))
                .opacity(0.8)
                .cornerRadius(16)
            }
        }
    }
}

struct LoadingOverlay_Previews: PreviewProvider {
    static var previews: some View {
        LoadingOverlay(
            animation: LoaderAnimation.bubbles,
            isLoading: true)
    }
}

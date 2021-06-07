//
//  StretchyImage.swift
//  Freshi
//
//  Created by Casey Roby on 5/31/21.
//
import SwiftUI

struct StretchyImage: View {
    let imageName: String
    var body: some View {
        GeometryReader { geo in
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geo.size.width)
        }
    }
}

struct StretchyImage_Previews: PreviewProvider {
    static var previews: some View {
        StretchyImage(imageName: "landing-collage")
    }
}

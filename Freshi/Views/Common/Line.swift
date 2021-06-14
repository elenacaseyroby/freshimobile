//
//  FreshiDivider.swift
//  Freshi
//
//  Created by Casey Roby on 5/28/21.
//

import SwiftUI

struct Line: View {
    let color: Color = Color("lowContrast")
    let height: CGFloat = 2.0
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: self.height)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Line()
    }
}

//
//  SignUp.swift
//  Freshi
//
//  Created by Casey Roby on 6/1/21.
//
import SwiftUI


struct SignUp: View {
    @State var currentPage: Float = 1
    var totalPages: Float = 5
    
    func percent(value: Float, total: Float) -> CGFloat {
        let percent: Float = value / total
        let roundedPercent = roundToDecPlace(value: percent, place: 2)
        return CGFloat(roundedPercent)
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(title: "Sign up")
                // Show progress from last page to current page.
                ProgressBar(
                    fromPercent: percent(
                        value: self.currentPage - 1, total: self.totalPages),
                    toPercent: percent(
                        value: self.currentPage, total: self.totalPages)
                )
            }
            // Top aligned
            Spacer()
        }
        .background(Color("background"))
        .padding(.leading, GlobalStyles.padding)
        .padding(.trailing, GlobalStyles.padding)
        
    }
}
// strictly for dev previews in xcode.
struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}


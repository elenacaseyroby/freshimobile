//
//  LogInView.swift
//  Freshi
//
//  Created by Casey Roby on 5/27/21.
//
import SwiftUI


struct LogIn: View {
    @State var isActive: Bool = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var destination: String? = nil
    
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            // Header
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Header(title: "Log in")
                Line()
            }
            // Buttons
            HStack(alignment: .center, spacing: 10){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("back-arrow")
                }
                .stretchyButton(state: StretchyButtonState.neutral, isSquare: true)
                SignUpNavButton()
                    
            }
            .padding(.leading, GlobalStyles.padding)
            .padding(.trailing, GlobalStyles.padding)
            // Top align.
            Spacer()
        }
        .background(Color("background"))

    }
}
// strictly for dev previews in xcode.
struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}


//
//  StartButtonView.swift
//  GloryHub
//
//  Created by Shugaban Media on 02/02/2021.
//

import SwiftUI

struct StartButtonView: View {
    // MARK: - PROPERTIES
    
    @Binding var currentStage: String
    @AppStorage("appStage") var appStage: String?
    
    
    // MARK: - BODY
    var body: some View {
        
        Button(action: {
            //appStage = "LoginView"
            self.currentStage = "SignupView"
        }) {
            HStack (spacing: 8) {
                Text("START")
                    .foregroundColor(Color("ColorAccentOppBlack"))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .foregroundColor(Color("ColorYellowButton"))
        } //: BUTTON
        .accentColor(Color("ColorYellowButton"))
        .background(Color("ColorYellowButton"))
        .cornerRadius(20)
        
        
    }
}

    // MARK - PREVIEW


struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView(currentStage: .constant("LoginView"))
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
 

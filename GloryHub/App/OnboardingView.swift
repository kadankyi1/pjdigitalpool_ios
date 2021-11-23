//
//  OnboardingView.swift
//  GloryHub
//
//  Created by Shugaban Media on 02/02/2021.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTIES
    //@AppStorage("appStage") var appStage: String?
    var start: [StarterModel] = startData
    @Binding var currentStage: String
    
    // MARK: - BODY
    var body: some View {
        TabView {
            ForEach(start[0...1]) { item in
                StartCardView(start: item, currentStage: $currentStage)
            } //: LOOP
        } //: TAB
        .tabViewStyle(PageTabViewStyle())
        //.padding(.vertical, 10)
    }
}

// MARK: - PREVIEW


struct OnboardingView_Previews: PreviewProvider {
    @Binding var currentStage: String
    static var previews: some View {
        OnboardingView(start: startData, currentStage: .constant("SignupView"))
    }
}
 
 

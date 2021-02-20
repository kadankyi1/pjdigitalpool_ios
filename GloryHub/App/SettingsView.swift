//
//  SettingsView.swift
//  GloryHub
//
//  Created by Shugaban Media on 20/02/2021.
//

import SwiftUI

struct SettingsView: View {
    // MARK: -- PROPERTIES
    var user_name: String
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: -- BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 20){
                    // MARK: -- SECTION 1
                    
                    GroupBox(label: Text(user_name)){
                        
                        
                    }
                    Divider().padding(.vertical, 2)
                    // MARK: -- SECTION 2
                    GroupBox(){
                        SettingsRowView(icon: "prayer", name: "Prayer Requests")
                        Divider().padding(.vertical, 2)
                        SettingsRowView(icon: "positive-vote", name: "Feedback")
                        Divider().padding(.vertical, 2)
                        SettingsRowView(icon: "rate", name: "Testimonies")
                        Divider().padding(.vertical, 2)
                        SettingsRowView(icon: "donation", name: "Partnership")
                        
                    }
                    Divider().padding(.vertical, 2)
                    GroupBox(){
                        SettingsRowView(icon: "speech", name: "", content: nil, linkLabel: "Christ Witness", linkDestination: "https://www.facebook.com/thegloriouschurch11")
                        SettingsRowView(icon: "holy-ghost", name: "", content: nil, linkLabel: "Holy Generation", linkDestination: "https://www.facebook.com/theHoly.Generation20")
                        
                    }
                }
            } // SCROLLVIEW
        } // NAVIGATION
        .padding(.horizontal, 20)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(user_name: "Mark Caw")
    }
}

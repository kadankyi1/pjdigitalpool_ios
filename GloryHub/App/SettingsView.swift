//
//  SettingsView.swift
//  GloryHub
//
//  Created by Shugaban Media on 20/02/2021.
//

import SwiftUI

struct SettingsView: View {
    // MARK: -- PROPERTIES
    @Binding var currentStage: String
    var user_name: String
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: -- BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 20){
                    // MARK: -- SECTION 1
                    
                    GroupBox(){
                        SettingsLogoutView(currentStage: .constant("MainView"),  icon: user_name, name: "Log Out")
                    }
                    Divider().padding(.vertical, 2)
                    // MARK: -- SECTION 2
                    GroupBox(){
                        NavigationLink(destination:
                                        ContactUsView(contact_type: "Prayer Request", textfield_msg: "Type your prayer request", poster_image: "prayerrequest", currentStage: .constant("SignupView"))){
                            SettingsRowView(icon: "prayer", name: "Prayer Requests")
                        }
                        Divider().padding(.vertical, 2)
                        NavigationLink(destination:
                                        ContactUsView(contact_type: "Feedback", textfield_msg: "Type your feedback here", poster_image: "feedback", currentStage: .constant("SignupView"))){
                            SettingsRowView(icon: "positive-vote", name: "Feedback")
                        }
                        Divider().padding(.vertical, 2)
                        NavigationLink(destination:
                                        ContactUsView(contact_type: "Testimonies", textfield_msg: "Type your testimony here", poster_image: "testimonies", currentStage: .constant("SignupView"))){
                            SettingsRowView(icon: "rate", name: "Testimonies")
                        }
                        Divider().padding(.vertical, 2)
                        NavigationLink(destination:PartnershipView(contact_type: "Partnership", textfield_msg: "Type your testimony here", poster_image: "partnership", currentStage: .constant("SignupView"))){
                            SettingsRowView(icon: "donation", name: "Partnership")
                        }
                        
                    }
                    Divider().padding(.vertical, 2)
                    GroupBox(){
                        
                        SettingsRowView(icon: "hog", name: "", content: nil, linkLabel: "Heralding The Glorious Church", linkDestination: "https://web.facebook.com/TheGloriousChurchNOTADENOMINATION")
                        SettingsRowView(icon: "thg", name: "", content: nil, linkLabel: "The Holy Generation", linkDestination: "https://www.facebook.com/theHoly.Generation20")
                        SettingsRowView(icon: "struggle", name: "", content: nil, linkLabel: "Impact Train", linkDestination: "https://thegloryhub.fishpott.com/uploads/pdfs/hog.pdf")
                        
                    }
                }
            } // SCROLLVIEW
            .padding(.horizontal, 20)
        } // NAVIGATION
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(currentStage: .constant("MainView"), user_name: "Mark Caw")
    }
}

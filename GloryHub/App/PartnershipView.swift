//
//  PartnershipView.swift
//  GloryHub
//
//  Created by Shugaban Media on 20/02/2021.
//

import SwiftUI
import SwiftyJSON

struct PartnershipView: View {
    // MARK: -- PROPERTIES
    
    @State var showsAlert = false
    var contact_type: String
    var textfield_msg: String
    var poster_image: String
    @State private var isAnimatingImage: Bool = false
    @State var text: String = "Type here"
    var access_token: String = getSavedString("user_accesstoken");
    @ObservedObject var model: MyModel = MyModel()
    @Binding var currentStage: String
    @State private var user_firstname: String = getSavedString("user_firstname")
    @State private var user_lastname: String = getSavedString("user_lastname")
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .center, spacing: 20){
                    // HEADER
                    ZStack {
                        /*
                         LinearGradient(gradient: Gradient(colors: [Color("ColorPrimaryBlue"), Color("ColorArticleHeraldOfGlory")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                         */
                        
                        Image(poster_image)
                            .resizable()
                            .shadow(radius: 4)
                            .frame(minWidth: 0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 250, idealHeight: 300, maxHeight: 250, alignment: /*@START_MENU_TOKEN@*/.center)
                        
                    }
                    .frame(height: 200)
                    .onAppear(){
                        withAnimation(.easeOut(duration: 0.5)){
                            isAnimatingImage = true
                        }
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 20){
                        
                        // TITLE
                        GroupBox(label: Text("Mobile Money").fontWeight(.heavy)){}
                        
                        GroupBox(){
                            SettingsRowView(icon: "", name: "Number: 0244528637")
                            SettingsRowView(icon: "", name: "Name: Christ Ecclesia Worldwide")
                            
                        }
                        Divider().padding(.vertical, 2)
                        GroupBox(label: Text("Bank").fontWeight(.heavy)){}
                        
                        GroupBox(){
                            SettingsRowView(icon: "", name: "CAL Bank")
                            SettingsRowView(icon: "", name: "Legon Branch")
                            SettingsRowView(icon: "", name: "CAW Gospel Ambassadors Network")
                            SettingsRowView(icon: "", name: "1400006809156")
                            //SettingsRowView(icon: "", name: "SWIFT/IBAN: 11111111")
                            
                        }
                        
                        
                    } //: VSTACK
                    .padding(.horizontal, 20)
                    .padding(.top, 50)
                    .frame(maxWidth: 640, alignment: .center)
                } //: VSTACK
                .navigationBarTitle(poster_image, displayMode: .inline)
                .navigationBarHidden(true)
            } //: SCROLLVIEW
            .edgesIgnoringSafeArea(.top)
        } //: NAVIGATION
    }
}

struct PartnershipView_Previews: PreviewProvider {
    static var previews: some View {
        PartnershipView(contact_type: "Testimonies", textfield_msg: "Type your testimony here", poster_image: "partnership", currentStage: .constant("SignupView"))
    }
}



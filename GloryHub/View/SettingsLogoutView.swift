//
//  SettingsLogoutView.swift
//  GloryHub
//
//  Created by Dankyi Anno Kwaku on 11/21/21.
//

import SwiftUI

struct SettingsLogoutView: View {
    // MARK: -- PROPERTIES
    
    var icon: String
    var name: String
    var content: String? = nil
    var linkLabel: String? = nil
    var linkDestination: String? = nil
    
    
    // MARK: -- BODY
    var body: some View {
        HStack {
            Text(icon).foregroundColor(Color.gray)
            Spacer()
            Text(name).foregroundColor(Color.gray)
            
            if(content != nil){
                
            } else if(linkLabel != nil && linkDestination != nil){
                Link(linkLabel!, destination: URL(string: linkDestination!)!)
                Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
            } else {
                EmptyView()
            }
        }
    }
}


// MARK: -- PREVIEW
struct SettingsLogoutView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(icon: "newwitness",name: "Prayer Requests")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}

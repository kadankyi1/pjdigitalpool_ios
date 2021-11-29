//
//  LibraryView.swift
//  GloryHub
//
//  Created by Dankyi Anno Kwaku on 27/02/2021.
//

import SwiftUI

struct LibraryView: View {
    // MARK: -- PROPERTIES
    var body: some View {
        
            NavigationView {
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 20){
                        // MARK: -- SECTION
                        GroupBox(){
                            NavigationLink(destination:
                                            LibraryMediaListView(fetch_type: "audios", fetch_url: "http://144.202.76.74/api/v1/admin/audios/list", favorite_ids: "")){
                                LibraryOptionRowView(icon: "audioopt", name: "Audios")
                            }
                            
                        }
                        .padding()
                        .clipped()
                        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                        
                        Divider().padding(.vertical, 15)
                        
                        GroupBox(){
                            NavigationLink(destination:
                                            LibraryMediaListView(fetch_type: "videos", fetch_url: "http://144.202.76.74/api/v1/admin/videos/list", favorite_ids: "")){
                                LibraryOptionRowView(icon: "videoopttt", name: "Videos")
                            }
                            
                        }
                        .padding()
                        .clipped()
                        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                        
                        Divider().padding(.vertical, 15)
                        
                        GroupBox(){
                            NavigationLink(destination:
                                            LibraryMediaListView(fetch_type: "favorites", fetch_url: "http://144.202.76.74/api/v1/admin/favorites/list", favorite_ids: "2")){
                                LibraryOptionRowView(icon: "favopt", name: "Favorites")
                            }
                            
                        }
                        .padding()
                        .clipped()
                        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                    }
                } // SCROLLVIEW
            } // NAVIGATION
            .padding(.horizontal, 20)
        
    } // BODY
}

    // MARK: -- PROPERTIES
struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}


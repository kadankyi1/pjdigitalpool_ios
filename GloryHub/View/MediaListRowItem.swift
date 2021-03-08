//
//  ReadArticleRowView.swift
//  GloryHub
//
//  Created by Shugaban Media on 16/02/2021.
//

import SwiftUI
import URLImage // Import the package module

struct MediaListRowItem: View {
    // MARK: - PROPERTIES
    var media: MediaModel
    
    // MARK: - BODY
    var body: some View {
        HStack{
            let this_url = URL(string: media.image);
            URLImage(url: this_url!,
                     content: { image in
                         image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120, alignment: .center)
                            .clipped()
                            .cornerRadius(8)
                            /*
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120, alignment: .center)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 3, x: 2, y: 2)
                            .background(LinearGradient(gradient: Gradient(colors: [Color("ColorBlueInLoggedSpace")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                            .cornerRadius(8)
                            */
                     })
            
            VStack(alignment: .leading, spacing: 5){
                Text(media.title)
                    .font(.callout)
                    .fontWeight(.bold)
                
                Image(media.type)
                       .resizable()
                       .scaledToFill()
                       .frame(width: 35, height: 35, alignment: .center)
                       .clipped()
                       .cornerRadius(8)
            }
        }
        .padding()
        //.frame(width: .infinity, height: 150, alignment: .trailing)
        //.background(Color.white)
        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
    }
}

// MARK: - PREVIEW
struct MediaListRowItem_Previews: PreviewProvider {
    static var previews: some View {
        MediaListRowItem(media:
                            MediaModel(
                               sku: "1",
                               type: "video",
                               title: "Test Video Name",
                               body: "Test Description",
                               image: "jjjjjj",
                               badge_color: "",
                               date: "Dec 2021",
                               url: "video.mp4",
                               badge_text: ""
                           ))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

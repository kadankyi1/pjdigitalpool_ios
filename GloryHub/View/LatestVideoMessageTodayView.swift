//
//  ReadArticleRowView.swift
//  GloryHub
//
//  Created by Shugaban Media on 16/02/2021.
//

import SwiftUI
import URLImage // Import the package module

struct LatestVideoMessageTodayView: View {
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
                            .frame(width: 120, height: 100, alignment: .center)
                            .clipShape(Circle())
                     })
            
        VStack(alignment: .leading, spacing: 5){
            Text(media.title)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(media.body.prefix(50) + "...")
                .font(.caption)
                .foregroundColor(Color.secondary)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            
                HStack{
                    Text("   \(media.badge_text)   ")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color("ColorAccentWhite"))
                        .background(Color("ColorGrayTwo"))
                        .cornerRadius(2)
                    Spacer()
                }
        }
            /*
             /*
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
                             .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                             .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 3, x: 2, y: 2)
                             .background(LinearGradient(gradient: Gradient(colors: [Color("ColorBlueInLoggedSpace")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                             .cornerRadius(8)
                             */
                      })
                 */
             */
            
        }
        
    }
}

// MARK: - PREVIEW
struct LatestVideoMessageTodayView_Previews: PreviewProvider {
    static var previews: some View {
        HeraldOfGloryTodayView(media: MediaModel(
            sku: "1",
            type: "audio",
            title: "MRS HERALD",
            body: "Knowing that Mrs Mallard was in tune with herself, he tried to learn. Knowing that Mrs Mallard was in tune with herself, he tried to learn. Knowing that Mrs Mallard was in tune with herself, he tried to learn. ",
            image: "feedback",
            badge_color: "ColorArticleHeraldOfGlory",
            date: "Dec 14 2020",
            url: "ColorArticleHeraldOfGlory",
            badge_text: "LATEST MESSAGE"
          )
        )
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

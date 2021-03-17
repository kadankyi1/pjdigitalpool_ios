//
//  AdvertCarouselView.swift
//  GloryHub
//
//  Created by Shugaban Media on 24/02/2021.
//

import SwiftUI

struct AdvertCarouselView: View {
    // MARK: -- PROPERTIES
    let showTitle: Bool
    let title: String
    let advert: [String]
    
    // MARK: -- BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            if showTitle{
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 20) {
                    ForEach(0..<2) { movie in
                        NavigationLink(destination: ContactUsView(contact_type: "Prayer Request", textfield_msg: "The test", poster_image: advert[movie], currentStage: .constant("SignupView"))) {
                            MoviePosterCard(advert: advert[movie])
                                .frame(width:400, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
            }
        } // VSTACK
    }
}


// MARK: -- PREVIEW
struct AdvertCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        AdvertCarouselView(showTitle: false, title: "Now Playing", advert: ["feedback", "partnership", "feedback", "partnership"])
    }
}

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
            
            MoviePosterCard(advert: advert[0])
        } // VSTACK
    }
}


// MARK: -- PREVIEW
struct AdvertCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        AdvertCarouselView(showTitle: false, title: "Now Playing", advert: ["feedback", "partnership"])
    }
}

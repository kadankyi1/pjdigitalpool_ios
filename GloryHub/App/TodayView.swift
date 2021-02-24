//
//  TodayView.swift
//  GloryHub
//
//  Created by Shugaban Media on 24/02/2021.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            AdvertCarouselView(showTitle: true, title: "Welcome Caw", advert: ["partnership", "feedback", "partnership", "feedback", "partnership", "feedback", "partnership"])
            
            
            GroupBox(){
            HeraldOfGloryTodayView(
                media: MediaModel(
                    sku: 1,
                    type: "audio",
                    title: "MRS HERALD",
                    body: "Knowing that Mrs Mallard was in tune with herself, he tried to learn. Knowing that Mrs Mallard was in tune with herself, he tried to learn. Knowing that Mrs Mallard was in tune with herself, he tried to learn. ",
                    image: "feedback",
                    badge_color: "ColorArticleHeraldOfGlory",
                    date: "Dec 14 2020",
                    url: "ColorArticleHeraldOfGlory"
                    )
            )
            }
            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            .padding(.horizontal, 10)
            .padding(.top, 20)
            
            GroupBox(){
            HeraldOfGloryTodayView(
                media: MediaModel(
                    sku: 1,
                    type: "audio",
                    title: "MRS HERALD",
                    body: "Knowing that Mrs Mallard was in tune with herself, he tried to learn. Knowing that Mrs Mallard was in tune with herself, he tried to learn. Knowing that Mrs Mallard was in tune with herself, he tried to learn. ",
                    image: "feedback",
                    badge_color: "ColorArticleHeraldOfGlory",
                    date: "Dec 14 2020",
                    url: "ColorArticleHeraldOfGlory"
                    )
            )
            }
            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            .padding(.horizontal, 10)
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}

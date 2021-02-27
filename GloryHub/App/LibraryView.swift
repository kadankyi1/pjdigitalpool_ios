//
//  LibraryView.swift
//  GloryHub
//
//  Created by Shugaban Media on 27/02/2021.
//

import SwiftUI

struct LibraryView: View {
    // MARK: -- PROPERTIES
    var body: some View {
        AdvertCarouselView(showTitle: false, title: "Welcome " + getSavedString("user_firstname"), advert: [getSavedString("notice_image_one"), getSavedString("notice_image_two")])
        
    } // BODY
}

    // MARK: -- PROPERTIES
struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

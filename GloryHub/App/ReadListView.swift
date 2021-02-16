//
//  ReadListView.swift
//  GloryHub
//
//  Created by Shugaban Media on 16/02/2021.
//

import SwiftUI

struct ReadListView: View {
    // MARK: - PROPERTIES
    
    var articles: [ArticleModel] = articleData
    
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach(articles) { item in
                    ReadArticleRowView(article: item)
                        .padding(.vertical, 4)
                }
            }
        } // NAVIGATION
    }
}

// MARK: - PREVIEW

struct ReadListView_Previews: PreviewProvider {
    static var previews: some View {
        ReadListView(articles: articleData)
    }
}

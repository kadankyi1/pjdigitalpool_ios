//
//  ReadArticleRowView.swift
//  GloryHub
//
//  Created by Shugaban Media on 16/02/2021.
//

import SwiftUI
import URLImage // Import the package module

struct ReadArticleRowView: View {
    // MARK: - PROPERTIES
    var article: ArticleModel
    
    // MARK: - BODY
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text(article.title)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                Text(article.body.prefix(100) + "...")
                    .font(.caption)
                    .foregroundColor(Color.secondary)
                Text(" " + article.articletype + " ")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(Color.black)
                    .background(Color(article.badge_color))
                    .cornerRadius(2)
            }
            let this_url = URL(string: article.image);
            URLImage(url: this_url!,
                     content: { image in
                         image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120, alignment: .center)
                            .clipped()
                            .cornerRadius(8)
                     })
        }
    }
}

// MARK: - PREVIEW
struct ReadArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReadArticleRowView(article: articleData[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

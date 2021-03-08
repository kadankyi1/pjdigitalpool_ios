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
        GroupBox(){
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text(article.title)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                Text(article.body.prefix(100) + "...")
                    .font(.caption)
                    .foregroundColor(Color.secondary)
                Text("  " + article.articletype + "  ")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(Color.white)
                    .background(Color("ColorGrayTwo"))
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
        }
        }
        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
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

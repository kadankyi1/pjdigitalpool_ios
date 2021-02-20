//
//  ArticleDetailView.swift
//  GloryHub
//
//  Created by Shugaban Media on 20/02/2021.
//

import SwiftUI
import URLImage // Import the package module

struct ArticleDetailView: View {
    // MARK: -- PROPERTIES
    var article: ArticleModel
    @State private var isAnimatingImage: Bool = false
    
    // MARK: -- BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                    // HEADER
                    ZStack {
                        /*
                        LinearGradient(gradient: Gradient(colors: [Color("ColorPrimaryBlue"), Color("ColorArticleHeraldOfGlory")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        */
                        let this_url = URL(string: article.image);
                        URLImage(url: this_url!,
                                 content: { image in
                                     image
                                        .resizable()
                                        .scaledToFit()
                                        //.clipped()
                                        //.frame(width: 120, height: 120, alignment: .center)
                                        .padding(.vertical, 20)
                                        .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
                                 })
                        /*
                        Image(article.image)
                            .resizable()
                            .scaledToFit()
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                            .padding(.vertical, 20)
                            .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
                         */
                    }
                    .frame(height: 300)
                    .onAppear(){
                        withAnimation(.easeOut(duration: 0.5)){
                            isAnimatingImage = true
                        }
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 20){
                        // TITLE
                        Text(article.title)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("ColorPrimaryBlue"))
                        
                        // DATE
                        Text(article.article_date)
                            .font(.footnote)
                        
                        // DESCRIPTION
                        Text(article.body)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        
                    } //: VSTACK
                    .padding(.horizontal, 20)
                    .frame(maxWidth: 640, alignment: .center)
                } //: VSTACK
                .navigationBarTitle(article.title, displayMode: .inline)
                .navigationBarHidden(true)
            } //: SCROLLVIEW
            .edgesIgnoringSafeArea(.top)
        } //: NAVIGATION
    }
}


// MARK -- PREVIEW
struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: articleData[0])
    }
}

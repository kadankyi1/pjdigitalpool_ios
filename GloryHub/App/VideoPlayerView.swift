//
//  VideoPlayerView.swift
//  GloryHub
// http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
//  Created by Shugaban Media on 28/02/2021.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    // MARK: -- PROPERTIES
    var resource_url: String
    var title: String
    var description: String
    var date: String
    @State private var isAnimatingImage: Bool = false
    
    // MARK: -- BODY
    var body: some View {
        //Text("VideoPlayerView")
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                    // HEADER
                    ZStack {
                            VideoPlayer(player: AVPlayer(url:  URL(string: resource_url)!))
                                .padding(.vertical, 20)
                                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                    }
                    .frame(height: 500)
                    .padding(.top, 100)
                    .onAppear(){
                        withAnimation(.easeOut(duration: 0.5)){
                            isAnimatingImage = true
                        }
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 20){
                        // TITLE
                        Text(title)
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("ColorPrimaryBlue"))
                            .lineLimit(2)
                        
                        // DATE
                        Text(date)
                            .font(.footnote)
                        
                        // DESCRIPTION
                        Text(description)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        
                    } //: VSTACK
                    .padding(.horizontal, 20)
                    .frame(maxWidth: 640, alignment: .center)
                } //: VSTACK
                .navigationBarTitle(title, displayMode: .inline)
                .navigationBarHidden(true)
            } //: SCROLLVIEW
            .edgesIgnoringSafeArea(.top)
    }
}

// MARK: -- PREVIEW
struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(resource_url: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4", title: "Test Video", description: "Test Body o ooo oooo o ooo ooo ooo oo oo oo", date: "Dec 2021")
    }
}

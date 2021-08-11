//
//  VideoPlayerView.swift
//  GloryHub
// https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3
//  Created by Shugaban Media on 28/02/2021.
//

import SwiftUI
import AVKit
import URLImage // Import the package module

struct AudioPlayerView: View {
    // MARK: -- PROPERTIES
    var resource_url: String
    var image: String
    var title: String
    var description: String
    var date: String
    @State private var isAnimatingImage: Bool = false
    @State var player = AVPlayer()
    //var videoUrl: String = "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4"

    // MARK: -- BODY
    var body: some View {
        //Text("VideoPlayerView")
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                    // HEADER
                    ZStack {
                        VideoPlayer(player: player){
                            let this_url = URL(string: image);
                            URLImage(url: this_url!,
                                     content: { image in
                                         image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: .infinity)
                                            .edgesIgnoringSafeArea(.all)
                                            /*
                                            .scaledToFit()
                                            .frame(width: .infinity, height: .infinity, alignment: .center)
                                            .padding(.vertical, 20)
                                            .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
                                            */
                                        
                                     })
                        }
                                        .onAppear() {
                                                player = AVPlayer(url: URL(string: resource_url)!)
                                        }
                        /*
                         VideoPlayer(player: AVPlayer(url:  URL(string: resource_url)!)){
                            /*
                         let this_url = URL(string: image);
                            URLImage(url: this_url!,
                                     content: { image in
                                         image
                                            .resizable()
                                            .scaledToFit()
                                            //.clipped()
                                            .frame(width: .infinity, height: .infinity, alignment: .center)
                                            .padding(.vertical, 20)
                                            .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
                                        
                                     })
                            */
                            Image("prayerrequest")
                                .resizable()
                                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                                .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
                        }
                                .padding(.vertical, 20)
                                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                        */
                    }
                    .frame(height: 400)
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
struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView(resource_url: "https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3", image: "feedback", title: "Test Audio", description: "Test Body o ooo oooo o ooo ooo ooo oo oo oo", date: "Dec 2021")
    }
}

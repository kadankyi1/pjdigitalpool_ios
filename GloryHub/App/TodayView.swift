//
//  TodayView.swift
//  GloryHub
//
//  Created by Shugaban Media on 24/02/2021.
//

import SwiftUI
import URLImage // Import the package module

struct TodayView: View {
    
    @ObservedObject var add_change = changeAdd()
    @State var firstAddIsShowing: Bool = true
    @State var now = Date()
    
    var body: some View {
        
        var timer2 = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) {
            (_) in
            firstAddIsShowing = add_change.switch_add(showingFirstAdd: firstAddIsShowing)
            print("firstAddIsShowing: \(firstAddIsShowing)")
        }
         NavigationView {
            ScrollView(.vertical, showsIndicators: false){
        VStack(alignment: .leading, spacing: 16) {
            
            if firstAddIsShowing {
                let this_url = URL(string: getSavedString("notice_image_one"));
                URLImage(url: this_url!,
                         content: { image in
                             image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .shadow(radius: 4)
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 150, idealHeight: 150, maxHeight: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                         })
                
            } else {
                let this_url2 = URL(string: getSavedString("notice_image_two"));
                URLImage(url: this_url2!,
                         content: { image in
                             image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .shadow(radius: 4)
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 250, idealHeight: 250, maxHeight: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                         })
                
            }
            
            
                NavigationLink(destination:
                                AudioPlayerView(
                                    resource_url: getSavedString("latest_audio_mp3"),
                                    image: getSavedString("latest_audio_image"),
                                    title: getSavedString("latest_audio_name"),
                                    description: getSavedString("latest_audio_description"),
                                    date: getSavedString("latest_audio_date")
                                )
                ){
            GroupBox(){
            HeraldOfGloryTodayView(
                media: MediaModel(
                    sku: getSavedString("latest_audio_id"),
                    type: "audio",
                    title: getSavedString("latest_audio_name"),
                    body: getSavedString("latest_audio_description"),
                    image: getSavedString("latest_audio_image"),
                    badge_color: "ColorArticleHeraldOfGlory",
                    date: getSavedString("latest_audio_date"),
                    url: getSavedString("latest_audio_mp3"),
                    badge_text: "Listen To Audio"
                )
            )
            }
            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            .padding(.horizontal, 10)
            .padding(.top, 120)
                }
            
                NavigationLink(destination:
                                VideoPlayerView(
                                    resource_url: getSavedString("latest_video1_mp4"),
                                    title: getSavedString("latest_video1_name"),
                                    description: getSavedString("latest_video1_description"),
                                    date: getSavedString("latest_video1_date")
                                )
                ){
                        GroupBox(){
                        LatestVideoMessageTodayView(
                            media: MediaModel(
                                sku: getSavedString("latest_video1_id"),
                                type: "video",
                                title: getSavedString("latest_video1_name"),
                                body: getSavedString("latest_video1_description"),
                                image: getSavedString("latest_video1_image"),
                                badge_color: "ColorArticleHeraldOfGlory",
                                date: getSavedString("latest_video1_date"),
                                url: getSavedString("latest_video1_mp4"),
                                badge_text: "LATEST MESSAGE"
                                )
                           )
                        }
                        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal, 10)
            }
            
                NavigationLink(destination:
                                VideoPlayerView(
                                    resource_url: getSavedString("latest_video2_mp4"),
                                    title: getSavedString("latest_video2_name"),
                                    description: getSavedString("latest_video2_description"),
                                    date: getSavedString("latest_video2_date")
                                )
                ){
            GroupBox(){
            LatestVideoMessageTodayView(
                media: MediaModel(
                    sku: getSavedString("latest_video2_id"),
                    type: "video",
                    title: getSavedString("latest_video2_name"),
                    body: getSavedString("latest_video2_description"),
                    image: getSavedString("latest_video2_image"),
                    badge_color: "ColorArticleHeraldOfGlory",
                    date: getSavedString("latest_video2_date"),
                    url: getSavedString("latest_video2_mp4"),
                    badge_text: "LATEST MESSAGE"
                )
               )
            }
            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            .padding(.horizontal, 10)
                }
          }
         }
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}



class changeAdd: ObservableObject {
    
    func switch_add(showingFirstAdd: Bool) -> Bool {
            if showingFirstAdd {
                return false
            } else {
                return true
            }
        }
}

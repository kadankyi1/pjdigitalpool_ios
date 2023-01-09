//
//  TodayView.swift
//  GloryHub
//
//  Created by Shugaban Media on 24/02/2021.
//

import SwiftUI
import SwiftyJSON
import URLImage // Import the package module

struct TodayView: View {
    
    @ObservedObject var add_change = changeAdd()
    @State var firstAddIsShowing: Bool = true
    var access_token: String = getSavedString("user_accesstoken");
    @ObservedObject var todaycontent_http_manager = HttpGetTodayContent()
    @State var now = Date()
    
    var body: some View {
        
        var timer2 = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) {
            (_) in
            firstAddIsShowing = add_change.switch_add(showingFirstAdd: firstAddIsShowing)
            print("firstAddIsShowing: \(firstAddIsShowing)")
        }
        
         NavigationView {
             
        if todaycontent_http_manager.requestMade && todaycontent_http_manager.status == "success" {
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
                    badge_text: "LISTEN TO AUDIO"
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
                                badge_text: "LATEST VIDEO MESSAGE"
                                )
                           )
                        }
                        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal, 10)
            }
            
                NavigationLink(destination:
                                AudioPlayerView(
                                    resource_url: getSavedString("latest_video2_mp4"),
                                    image: getSavedString("latest_video2_image"),
                                    title: getSavedString("latest_video2_name"),
                                    description: getSavedString("latest_video2_description"),
                                    date: getSavedString("latest_video2_date")
                                )
                ){
            GroupBox(){
            LatestAudioMessageTodayView(
                media: MediaModel(
                    sku: getSavedString("latest_video2_id"),
                    type: "audio",
                    title: getSavedString("latest_video2_name"),
                    body: getSavedString("latest_video2_description"),
                    image: getSavedString("latest_video2_image"),
                    badge_color: "ColorArticleHeraldOfGlory",
                    date: getSavedString("latest_video2_date"),
                    url: getSavedString("latest_video2_mp4"),
                    badge_text: "LATEST AUDIO MESSAGE"
                )
               )
            }
            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            .padding(.horizontal, 10)
                }
          }
         }
        //} // SUCCESS
       } // REQUEST MADE
             else {
                 
                     ProgressView()
                     .onAppear(perform: {
                         print("Getting today's content")
                         todaycontent_http_manager.get_today_content(user_accesstoken: access_token, url: "https://thegloryhub.fishpott.com/api/v1/admin/today/dasboard")
                     })
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


        
        class HttpGetTodayContent: ObservableObject {

            @Published var requestMade = false
            @Published var values_set = false
            @Published var showProgress = false
            @Published var message = ""
            @Published var status = "failed"
            @Published var received_media: [MediaModel] = []

            func get_today_content(user_accesstoken: String, url: String) {
                guard let url = URL(string:url) else { return }

                let auth_pass = "Bearer " + user_accesstoken
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue(auth_pass, forHTTPHeaderField: "Authorization")

                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let data = data else { return }
                    print(data)
                    do {
                        let json = try JSON(data: data)
                        if let status = json["status"].string {
                          //Now you got your value
                            print("GOT MEDIA CONTENT")
                            print(status)
                            
                            DispatchQueue.main.async {
                                self.requestMade = true
                                self.status = status
                                if status == "success" {
                                    print(status)
                                    if let items = json["data"]["data"].array {
                                        
                                        
                                        if let notice_image_one = json["data"]["data"][0]["notice_image"].string {
                                            //Now you got your value
                                            saveTextInStorage("notice_image_one", notice_image_one)
                                            print("note_image_one: \(notice_image_one)")
                                          }
                                        
                                        if let notice_image_two = json["data"]["data"][1]["notice_image"].string {
                                            //Now you got your value
                                            saveTextInStorage("notice_image_two", notice_image_two)
                                            print("notice_image_two: \(notice_image_two)")
                                          }
                                        
                                        if let audio_id = json["audios"]["data"][0]["audio_id"].int {
                                            //Now you got your value
                                            saveTextInStorage("latest_audio_id", String(audio_id))
                                            print("audio_id: \(audio_id)")
                                            
                                            if let audio_name = json["audios"]["data"][0]["audio_name"].string {
                                                //Now you got your value
                                                saveTextInStorage("latest_audio_name", audio_name)
                                                print("latest_audio_name: \(audio_name)")
                                                if let audio_description = json["audios"]["data"][0]["audio_description"].string {
                                                    //Now you got your value
                                                    saveTextInStorage("latest_audio_description", audio_description)
                                                    print("latest_audio_description: \(audio_description)")
                                                    
                                                    if let audio_image = json["audios"]["data"][0]["audio_image"].string {
                                                        //Now you got your value
                                                        saveTextInStorage("latest_audio_image", audio_image)
                                                        print("latest_audio_image: \(audio_image)")
                                                        if let audio_mp3 = json["audios"]["data"][0]["audio_mp3"].string {
                                                            //Now you got your value
                                                            saveTextInStorage("latest_audio_mp3", audio_mp3)
                                                            print("latest_audio_mp3: \(audio_mp3)")
                                                            
                                                            if let created_at = json["audios"]["data"][0]["created_at"].string {
                                                                //Now you got your value
                                                                saveTextInStorage("latest_audio_date", created_at)
                                                                print("latest_audio_date: \(created_at)")
                                                              }
                                                          }
                                                      } //AUDIO IMAGE
                                                  }
                                              } // START FOR AUDIO NAME
                                          } // END FOR AUDIO ID
                                        
                                        
                                        if let video_id = json["videos"]["data"][0]["video_id"].int {
                                            //Now you got your value
                                            saveTextInStorage("latest_video1_id", String(video_id))
                                            print("latest_video1_id: \(video_id)")
                                            
                                            if let video_name = json["videos"]["data"][0]["video_name"].string {
                                                //Now you got your value
                                                saveTextInStorage("latest_video1_name", video_name)
                                                print("latest_video1_name: \(video_name)")
                                                
                                                if let video_description = json["videos"]["data"][0]["video_description"].string {
                                                    //Now you got your value
                                                    saveTextInStorage("latest_video1_description", video_description)
                                                    print("latest_video1_description: \(video_description)")
                                                    
                                                    if let video_image = json["videos"]["data"][0]["video_image"].string {
                                                        //Now you got your value
                                                        saveTextInStorage("latest_video1_image", video_image)
                                                        print("latest_video1_image: \(video_image)")
                                                        if let video_mp4 = json["videos"]["data"][0]["video_mp4"].string {
                                                            //Now you got your value
                                                            saveTextInStorage("latest_video1_mp4", video_mp4)
                                                            print("latest_video1_mp4: \(video_mp4)")
                                                            
                                                            if let created_at = json["videos"]["data"][0]["created_at"].string {
                                                                //Now you got your value
                                                                saveTextInStorage("latest_video1_date", created_at)
                                                                print("latest_video1_date: \(created_at)")
                                                              }
                                                          }
                                                      } //VIDEO IMAGE
                                                  }
                                              } // START FOR VIDEO NAME
                                          } // END FOR VIDEO ID
                                        
                                        if let video_id = json["latest_audios"]["data"][0]["audio_id"].int {
                                            //Now you got your value
                                            saveTextInStorage("latest_video2_id", String(video_id))
                                            print("latest_video2_id: \(video_id)")
                                            
                                            if let video_name = json["latest_audios"]["data"][0]["audio_name"].string {
                                                //Now you got your value
                                                saveTextInStorage("latest_video2_name", video_name)
                                                print("444 latest_video2_name: \(video_name)")
                                                
                                                if let video_description = json["latest_audios"]["data"][0]["audio_description"].string {
                                                    //Now you got your value
                                                    saveTextInStorage("latest_video2_description", video_description)
                                                    print("latest_video2_description: \(video_description)")
                                                    
                                                    if let video_image = json["latest_audios"]["data"][0]["audio_image"].string {
                                                        //Now you got your value
                                                        saveTextInStorage("latest_video2_image", video_image)
                                                        print("latest_video2_image: \(video_image)")
                                                        if let video_mp4 = json["latest_audios"]["data"][0]["audio_mp3"].string {
                                                            //Now you got your value
                                                            saveTextInStorage("latest_video2_mp4", video_mp4)
                                                            print("latest_video2_mp4: \(video_mp4)")
                                                            
                                                            if let created_at = json["latest_audios"]["data"][0]["created_at"].string {
                                                                //Now you got your value
                                                                saveTextInStorage("latest_video2_date", created_at)
                                                                print("latest_video2_date: \(created_at)")
                                                                self.values_set = true
                                                                self.showProgress = false
                                                              }
                                                          }
                                                      } //VIDEO IMAGE
                                                  }
                                              } // START FOR VIDEO NAME
                                          } // END FOR VIDEO ID
                                    } else {
                                        if let message = json["message"].string {
                                            //Now you got your value
                                              print(status)
                                              
                                              DispatchQueue.main.async {
                                                  self.message = message
                                              }
                                          }
                                    }
                                }
                            }
                        }
                    } catch  let error as NSError {
                        DispatchQueue.main.async {
                        self.requestMade = true
                        self.message = "Failed to get media"
                        print("Request failed 3")
                        }
                    }
                    
                }.resume()
            }
        }

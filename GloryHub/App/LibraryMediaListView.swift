//
//  ReadListView.swift
//  GloryHub
//
//

import SwiftUI
import SwiftyJSON

struct LibraryMediaListView: View {
    // MARK: - PROPERTIES
    
    var fetch_type: String
    var fetch_url: String
    var favorite_ids: String
    var access_token: String = getSavedString("user_accesstoken");
    @ObservedObject var model: MyModel2 = MyModel2()
    @ObservedObject var media_http_manager = HttpGetMediaContent()
    

    // MARK: - BODY
    var body: some View {
            if media_http_manager.requestMade {
                if (media_http_manager.status == "success"){
                    List {
                        ForEach(media_http_manager.received_media) { item in
                            if item.type == "video" {
                                NavigationLink(destination: VideoPlayerView(resource_url: item.url, title: item.title, description: item.body, date: item.date)){
                                    MediaListRowItem(media: item)
                                        .padding(.vertical, 4)
                                }
                            } else {
                                NavigationLink(destination: AudioPlayerView(resource_url: item.url, image: item.image, title: item.title, description: item.body, date: item.date)){
                                    MediaListRowItem(media: item)
                                        .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                } else {
                    VStack {}
                        .alert(isPresented: $model.isValid, content: {
                        Alert(title: Text("Oops"),
                              message: Text("Something went awry"),
                              dismissButton: .default(
                                Text("Okay"))
                                {
                                    //print("do something")
                                    
                                })
                    })
                }
            } else {
                ProgressView()
                .onAppear(perform: {
                    print("Access Token request starting")
                    media_http_manager.get_media_content(user_accesstoken: access_token, fetchtype: fetch_type, url: fetch_url, favs_id: favorite_ids)
                })
            }
    }
}

class MyModel2: ObservableObject {
    @Published var isValid: Bool = false

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.isValid = true
        }
    }
}

// MARK: - PREVIEW

struct LibraryMediaListView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryMediaListView(fetch_type: "audios", fetch_url: "http://144.202.76.74/api/v1/admin/audios/list", favorite_ids: "")
    }
}


class HttpGetMediaContent: ObservableObject {

    @Published var requestMade = false
    @Published var message = ""
    @Published var status = "failed"
    @Published var received_media: [MediaModel] = []

    func get_media_content(user_accesstoken: String, fetchtype: String, url: String, favs_id: String) {
        guard let url = URL(string:url) else { return }

        let auth_pass = "Bearer " + user_accesstoken
        
        var request = URLRequest(url: url)
        if fetchtype == "favorites" {
            request.httpMethod = "POST"
            let body: [String: String] = ["favorites": "[\(favs_id)]"]
            let finalBody = try! JSONSerialization.data(withJSONObject: body)
            request.httpBody = finalBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            request.httpMethod = "GET"
        }
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
                                
                            for item in items {
                            if (fetchtype == "audios" || fetchtype == "favorites"){
                                if let audio_id = item["audio_id"].int {
                                    print("audio_id: \(audio_id)")
                                    
                                    if let audio_name = item["audio_name"].string {
                                        print("latest_audio_name: \(audio_name)")
                                        
                                        if let audio_description = item["audio_description"].string {
                                            
                                            
                                            if let audio_image = item["audio_image"].string {
                                                print("latest_audio_image: \(audio_image)")
                                                
                                                if let audio_mp3 = item["audio_mp3"].string {
                                                    print("latest_audio_mp3: \(audio_mp3)")
                                                    
                                                    if let created_at = item["created_at"].string {
                                                        print("latest_audio_date: \(created_at)")
                                                        self.received_media.append(
                                                            MediaModel(
                                                               sku: String(audio_id),
                                                               type: "audio",
                                                               title: audio_name,
                                                               body: audio_description,
                                                               image: audio_image,
                                                               badge_color: "",
                                                               date: created_at,
                                                               url: audio_mp3,
                                                               badge_text: ""
                                                           )
                                                        )
                                                      }
                                                  }
                                              } //AUDIO IMAGE
                                          }
                                      } // START FOR AUDIO NAME
                                  } // END FOR AUDIO ID
                            }
                            
                            
                            if fetchtype == "videos"{
                                if let video_id = item["video_id"].int {
                                //Now you got your value
                                print("latest_video1_id: \(video_id)")
                                
                                if let video_name = item["video_name"].string {
                                    print("latest_video1_name: \(video_name)")
                                    
                                    if let video_description = item["video_description"].string {
                                        if let video_image = item["video_image"].string {
                                            print("latest_video1_image: \(video_image)")
                                            
                                            if let video_mp4 = item["video_mp4"].string {
                                                print("latest_video1_mp4: \(video_mp4)")
                                                
                                                if let created_at = item["created_at"].string {
                                                    print("latest_video1_date: \(created_at)")
                                                    
                                                    self.received_media.append(
                                                        MediaModel(
                                                           sku: String(video_id),
                                                           type: "video",
                                                           title: video_name,
                                                           body: video_description,
                                                           image: video_image,
                                                           badge_color: "",
                                                           date: created_at,
                                                           url: video_mp4,
                                                           badge_text: ""
                                                       )
                                                    )
                                                  }
                                              }
                                          } //VIDEO IMAGE
                                      }
                                  } // START FOR VIDEO NAME
                              } // END FOR VIDEO ID
                                } // END LOOP
                            } // END GETTING ARRAY
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

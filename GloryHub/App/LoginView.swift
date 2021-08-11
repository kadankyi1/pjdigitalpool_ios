//
//  ContentView.swift
//  GloryHub
//
//  Created by Shugaban Media on 01/02/2021.
//

import SwiftUI
import SwiftyJSON

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    //@State private var showLoginButton: Bool = true
    @ObservedObject var manager = HttpAuth()
    @ObservedObject var updateContent2 = HttpUpdateContentForLogin()
    @Binding var currentStage: String
    @State private var networking: Bool = false
        
        
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
            Image("CAW-app-Login-2")
                    .resizable()
                .scaleEffect(x: 1, y: 0.95, anchor: .top)
            
            if manager.requestMade {
                if !manager.authenticated {
                    Text(manager.message)
                    .font(.headline)
                    .foregroundColor(.red)
                        .onAppear(perform: {
                                networking = false;
                        })
                } else {
                    Text("Login Successful")
                    .font(.headline)
                    .foregroundColor(.green)
                    .onAppear(perform: {
                        saveTextInStorage("user_accesstoken", manager.accessToken)
                        saveTextInStorage("user_firstname", manager.userFirstName)
                        saveTextInStorage("user_lastname", manager.userLastName)
                        self.currentStage = "LoggedInView"
                        print("currentStage: \(self.currentStage)")
                    })
                }
            }
 
            
            TextField("Phone Number", text: $username).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .center)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
                //.position(x: 1, y: 1)
            
            
            SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .top)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
            
            if manager.showLoginButton {
                Button(action: {
                    print("\(self.username) and \(self.password)")
                    if networking == false {
                        networking = true;
                        manager.checkDetails(user_phone_number: self.username, password: self.password)
                    }
                    
                }) {
                    HStack (spacing: 8) {
                        Text("LOGIN")
                            .foregroundColor(Color("ColorAccentOppBlack"))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .foregroundColor(Color("ColorYellowButton"))
                } //: BUTTON
                .accentColor(Color("ColorYellowButton"))
                .background(Color("ColorYellowButton"))
                .cornerRadius(20)
                .padding(.bottom, 50)
                
            } else {
                ProgressView()
            }
            
             
             Text("Not A Member? Join Here")
                 .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                 .padding(.bottom, 10)
                 .onTapGesture {
                     self.currentStage = "SignupView"
                 }
            
            if updateContent2.showProgress {
                ProgressView().onDisappear(perform: {
                    networking = false;
                    if updateContent2.values_set {
                         self.currentStage = "LoggedInView"
                    }
                })
            } else {
             Text("Proceed As A Guest")
                .foregroundColor(.gray)
                 .padding(.bottom, 150)
                 .onTapGesture {
                    
                    if networking == false {
                        networking = true;
                        updateContent2.update_content();
                        if updateContent2.values_set {
                             self.currentStage = "LoggedInView"
                        }
                    }
                 }
            }
            
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(currentStage: .constant("SignupView"))
    }
}


class HttpAuth: ObservableObject {

    @Published var authenticated = false
    @Published var requestMade = false
    @Published var showLoginButton = true
    @Published var message = ""
    @Published var accessToken = ""
    @Published var userFirstName = ""
    @Published var userLastName = ""

    func checkDetails(user_phone_number: String, password: String) {
        showLoginButton = false
        guard let url = URL(string: "http://144.202.76.74/api/v1/member/login") else { return }

        let body: [String: String] = ["user_phone_number": user_phone_number, "password": password]

        let finalBody = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSON(data: data)
                if let status = json["status"].int {
                  //Now you got your value
                    print(status)
                    
                    DispatchQueue.main.async {
                        self.requestMade = true
                        if status == 1 {
                            print(status)
                            self.authenticated = true
                            if let thisaccesstoken = json["access_token"].string {
                                //Now you got your value
                                self.accessToken = thisaccesstoken
                                print("access_token: \(self.accessToken)")
                              }
                            if let firstname = json["user"]["user_firstname"].string {
                                //Now you got your value
                                self.userFirstName = firstname
                                print("userFirstName: \(self.userFirstName)")
                              }
                            if let surname = json["user"]["user_surname"].string {
                                //Now you got your value
                                self.userLastName = surname
                                print("surname: \(self.userLastName)")
                              }
                            
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
                                    print("333 latest_video2_name: \(video_name)")
                                    
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
                                                  }
                                              }
                                          } //VIDEO IMAGE
                                      }
                                  } // START FOR VIDEO NAME
                              } // END FOR VIDEO ID
                            
                            
                        } else {
                            self.authenticated = false;
                            self.showLoginButton = true
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
            } catch  let error as NSError {
                DispatchQueue.main.async {
                    self.requestMade = true
                    self.message = "Login failed"
                    self.authenticated = false
                    self.showLoginButton = true
                }
            }
            
            /*
            let resData = try! JSONDecoder().decode(ServerMessage.self, from: data)
            print(resData)
            if resData.res == "correct" {
                DispatchQueue.main.async {
                    self.authenticated = true
                }
            }
             */
            
        }.resume()
    }
}


class HttpUpdateContentForLogin: ObservableObject {

    @Published var requestMade = false
    @Published var values_set = false
    @Published var showProgress = false

    func update_content() {
        self.showProgress = true
        guard let url = URL(string: "http://144.202.76.74/api/v1/member/guest") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(auth_pass, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            print("data")
            print(data)
            do {
                let json = try JSON(data: data)
                if let status = json["status"].int {
                  //Now you got your value
                    print("UPDATED CONTENT")
                    print(status)
                    
                    DispatchQueue.main.async {
                        self.requestMade = true
                        if status == 1 {
                            print(status)
                            
                            if let thisaccesstoken = json["access_token"].string {
                                //Now you got your value
                                saveTextInStorage("user_accesstoken", thisaccesstoken)
                                print("GUEST access_token: \(thisaccesstoken)")
                              }
                            if let firstname = json["user"]["user_firstname"].string {
                                //Now you got your value
                                saveTextInStorage("user_firstname", firstname)
                                print("GUEST userFirstName: \(firstname)")
                              }
                            if let surname = json["user"]["user_surname"].string {
                                //Now you got your value
                                saveTextInStorage("user_lastname", surname)
                                print("GUEST surname: \(surname)")
                              }
                            
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
                            
                        }
                    }
                }
            } catch  let error as NSError {
                
                    DispatchQueue.main.async {
                    self.values_set = false
                    self.showProgress = false
                    }
            }
            
        }.resume()
    }
}

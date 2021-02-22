//
//  ContactUsView.swift
//  GloryHub
//
//  Created by Shugaban Media on 20/02/2021.
//

import SwiftUI

struct ContactUsView: View {
    // MARK: -- PROPERTIES
    
    @State var showsAlert = false
    var contact_type: String
    var textfield_msg: String
    var poster_image: String
    @State private var isAnimatingImage: Bool = false
    @ObservedObject var request_manager_send_request = SendMessageRequestHttpAuth()
    @State var text: String = "Type here"
    var access_token: String = getSavedString("user_accesstoken");
    @ObservedObject var model: MyModel = MyModel()
    
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .center, spacing: 20){
                    // HEADER
                    ZStack {
                        /*
                         LinearGradient(gradient: Gradient(colors: [Color("ColorPrimaryBlue"), Color("ColorArticleHeraldOfGlory")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                         */
                        
                        Image(poster_image)
                            .resizable()
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                            .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
                    }
                    .frame(height: 300)
                    .onAppear(){
                        withAnimation(.easeOut(duration: 0.5)){
                            isAnimatingImage = true
                        }
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 20){
                        
                        // TITLE
                        GroupBox(label: Text(contact_type).fontWeight(.heavy)){}
                        Divider().padding(.vertical, 2)
                        
                        // DESCRIPTION
                        ZStack {
                            TextEditor(text: $text)
                            .foregroundColor(.secondary)
                            //.background(.gray)
                            Text(text).opacity(0).padding(.all, 8) // <- This will solve the issue if it is in the same ZStack
                        }
                        
                        if request_manager_send_request.showButton {
                            Button(action: {
                                print("message_type \(contact_type)")
                                print("access_token \(access_token)")
                                request_manager_send_request.sendMessage(user_accesstoken: access_token, message_type: contact_type, message_text: text)
                                
                            }) {
                                HStack (spacing: 8) {
                                    Text("SEND")
                                        .foregroundColor(Color("ColorAccentOppBlack"))
                                }
                                .padding(.horizontal, 30)
                                .padding(.vertical, 10)
                                .foregroundColor(Color("ColorYellowButton"))
                            } //: BUTTON
                            .accentColor(Color("ColorYellowButton"))
                            .background(Color("ColorYellowButton"))
                            .cornerRadius(20)
                            .padding(.bottom, 50)
                            .padding(.horizontal, 100)
                            
                            if request_manager_send_request.requestMade {
                                VStack {}
                                    .alert(isPresented: $model.isValid, content: {
                                    Alert(title: Text("Reply"),
                                          message: Text(request_manager_send_request.message),
                                          dismissButton: .default(
                                            Text("Okay"))
                                            {
                                                //print("do something")
                                                
                                            })
                                })
                            }
                        } else {
                            ProgressView()
                                .padding(.horizontal, 150)
                        }
                        
                        
                    } //: VSTACK
                    .padding(.horizontal, 20)
                    .frame(maxWidth: 640, alignment: .center)
                } //: VSTACK
                .navigationBarTitle(poster_image, displayMode: .inline)
                .navigationBarHidden(true)
            } //: SCROLLVIEW
            .edgesIgnoringSafeArea(.top)
        } //: NAVIGATION
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView(contact_type: "Testimonies", textfield_msg: "Type your testimony here", poster_image: "partnership")
    }
}


class SendMessageRequestHttpAuth: ObservableObject {

    @Published var requestMade = false
    @Published var showButton = true
    @Published var message = ""

    func sendMessage(user_accesstoken: String, message_type: String, message_text: String) {
        self.showButton = false
        guard let url = URL(string: "http://144.202.76.74/api/v1/admin/messages/add") else { return }

        let body: [String: String] = ["message_type": message_type, "message_text": message_text]

        let finalBody = try! JSONSerialization.data(withJSONObject: body)

        let auth_pass = "Bearer " + user_accesstoken
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(auth_pass, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            print("data")
            print(data)
            do {
                let json = try JSON(data: data)
                if let message = json["message"].string {
                    //Now you got your value
                      print(message)
                      DispatchQueue.main.async {
                          self.message = message
                          self.showButton = true
                          self.requestMade = true
                      }
                }
            } catch  let error as NSError {
                DispatchQueue.main.async {
                    self.message = "Failed to send"
                    self.showButton = true
                    self.requestMade = true
                }
            }
            
            
        }.resume()
    }
}

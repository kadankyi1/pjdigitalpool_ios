//
//  ContentView.swift
//  GloryHub
//
//  Created by Shugaban Media on 01/02/2021.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    //@State private var showLoginButton: Bool = true
    @ObservedObject var manager = HttpAuth()
    @Binding var currentStage: String
        
        
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
                    manager.checkDetails(user_phone_number: self.username, password: self.password)
                    
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
                .padding(.bottom, 150)
                .onTapGesture {
                    self.currentStage = "SignupView"
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

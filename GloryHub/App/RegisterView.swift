//
//  ContentView.swift
//  GloryHub
//
//  Created by Shugaban Media on 01/02/2021.
//

import SwiftUI
import Alamofire

struct RegisterView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    //@State private var showLoginButton: Bool = true
    @ObservedObject var manager = HttpAuthh()
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
 
            
            TextField("RegPhone Number", text: $username).textFieldStyle(RoundedBorderTextFieldStyle.init())
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
                    self.currentStage = "LoginView"
                }
            
        }
    }
}



struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(currentStage: .constant("SignupView"))
    }
}


class HttpAuthh: ObservableObject {

    @Published var authenticated = false
    @Published var requestMade = false
    @Published var showLoginButton = true
    @Published var message = ""
    @Published var accessToken = ""
    @Published var userFirstName = ""
    @Published var userLastName = ""

    func checkDetails(user_phone_number: String, password: String) {
        showLoginButton = false
        
        let body: [String: String] = [
            
                "user_firstname": "Sanct",
                "user_laname": "Tily",
                "user_country": "Ghana",
                "user_phone_number": "+233252912989",
                "user_email": "iburussanctum98@hymail.com",
                "password": password,
                "password_confirmation": password
        ]

        //"Content-Type": "application/x-www-form-urlencoded"
        //"Accept": "application/json"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        AF.request(URL.init(string: "http://144.202.76.74/api/v1/member/loginn")!, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
                print(response.result)

                switch response.result {

                case .success(_):
                    if let json = response.value
                    {
                        //successHandler((json as! [String:AnyObject]))
                        
                        print(json)
                    }
                    break
                case .failure(let error):
                    print(error.errorDescription)
                    break
                }
            }
    }
}

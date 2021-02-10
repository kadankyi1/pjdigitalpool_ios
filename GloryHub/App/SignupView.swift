//
//  ContentView.swift
//  GloryHub
//
//  Created by Shugaban Media on 01/02/2021.
//

import SwiftUI

struct SignupView: View {
    
    @State private var first_name: String = ""
    @State private var last_name: String = ""
    @State private var country: String = ""
    @State private var phone_number: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var repeat_password: String = ""
    
    //@State private var showLoginButton: Bool = true
    @ObservedObject var manager = SignupHttpAuth()
    @Binding var currentStage: String
        
    @State private var lastSelectedIndex: Int?
    
    @State var countries = ["India","USA","France"] //Here Add Your data
    @State var countryIndex = 0
    
        
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
            Image("CAW-app-let-us-know-u-2")
                    .resizable()
                .scaleEffect(x: 1, y: 1.1, anchor: .top)
            
            if manager.requestMade {
                if !manager.authenticated {
                    Text(manager.message)
                    .font(.headline)
                    .foregroundColor(.red)
                }
            }
 
            TextField("First Name", text: $first_name).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .center)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
            
            TextField("Last Name", text: $last_name).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .center)
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
            
            PickerTextField(data: ["1", "2", "3"],placeholder: "Select Country",lastSelectedIndex: self.$lastSelectedIndex)
                .frame(height: 10, alignment: .bottom)
                .scaleEffect(x: 1, y: 1, anchor: .center)
                .padding(.horizontal, 50)
                //.padding(.vertical, 100)
                .padding(.bottom, -100)
                .padding(.top, -25)
            
            /*
            NavigationView {
                Form {
                    Section {
                        Picker(selection: $countryIndex, label: Text("Country"), content: {
                            ForEach(0..<countries.count){
                                Text(self.countries[$0]).tag([$0])
                            }
                            .navigationBarTitle(Text("country"))
                        })
                        .frame(height: 0, alignment: .bottom)
                    }
                    .frame(height: -10, alignment: .bottom)
                }
                .frame(height: 70, alignment: .bottom)
            }
            .frame(height: 10, alignment: .bottom)
            .scaleEffect(x: 1, y: 1, anchor: .center)
            .padding(.horizontal, 50)
            .padding(.vertical, 100)
             */
                    
            /*
                TextField("Country", text: $country).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .center)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
            */
            
            TextField("Phone Number", text: $phone_number).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .center)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
            
            TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .center)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
            
            
            SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .top)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
            
            if manager.showLoginButton {
                Button(action: {
                    print("first_name: \(self.first_name)")
                    print("last_name: \(self.last_name)")
                    print("country: \(self.country)")
                    print("phone_number: \(self.phone_number)")
                    print("email: \(self.email)")
                    print("password: \(self.password)")
                    //print("repeat_password: \(self.repeat_password)")
                    manager.checkDetails(
                        first_name: self.first_name,
                        last_name: self.last_name,
                        country: self.country,
                        phone_number: self.phone_number,
                        email: self.email,
                        password: self.password,
                        repeat_password: self.password
                    )
                }) {
                    HStack (spacing: 8) {
                        Text("SIGN UP")
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
            
            Text("Sign-In Here")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .padding(.bottom, 25)
                .onTapGesture {
                    self.currentStage = "LoginView"
                }
        }
    }
}



struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(currentStage: .constant("LoginView"))
    }
}


class SignupHttpAuth: ObservableObject {

    @Published var authenticated = false
    @Published var requestMade = false
    @Published var showLoginButton = true
    @Published var message = ""

    func checkDetails(
        first_name: String,
        last_name: String,
        country: String,
        phone_number: String,
        email: String,
        password: String,
        repeat_password: String) {
        showLoginButton = false
        guard let url = URL(string: "http://144.202.76.74/api/v1/member/register") else { return }

        let body: [String: String] =
            [
                "user_firstname": first_name,
                "user_lastname": last_name,
                "user_country": country,
                "user_phone_number": phone_number,
                "user_email": email,
                "password": password,
                "password_confirmation": repeat_password
            ]

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
                            self.authenticated = true
                        } else {
                            self.authenticated = false
                            self.showLoginButton = true
                            if let message = json["message"].string {
                                //Now you got your value
                                  print(status)
                                  self.message = message
                              }
                        }
                    }
                }
            } catch  let error as NSError {
                DispatchQueue.main.async {
                    self.requestMade = true
                    self.message = "Registration failed"
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

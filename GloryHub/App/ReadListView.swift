//
//  ReadListView.swift
//  GloryHub
//
//  Created by Shugaban Media on 16/02/2021.
//

import SwiftUI

struct ReadListView: View {
    // MARK: - PROPERTIES
    
    var articles: [ArticleModel] = articleData
    var access_token: String = getSavedString("user_accesstoken");
    @ObservedObject var model: MyModel = MyModel()
    @ObservedObject var articles_http_manager = HttpGetReadArticles()
    

    // MARK: - BODY
    var body: some View {
        NavigationView {
            if articles_http_manager.requestMade {
                if (articles_http_manager.status == "success"){
                    List {
                        ForEach(articles) { item in
                            ReadArticleRowView(article: item)
                                .padding(.vertical, 4)
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
                Text("Getting articles")
                .font(.headline)
                .foregroundColor(.green)
                .onAppear(perform: {
                    print("Access Token request starting")
                    articles_http_manager.getArticles(user_accesstoken: access_token)
                })
            }
            
        } // NAVIGATION
    }
}

class MyModel: ObservableObject {
    @Published var isValid: Bool = false

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.isValid = true
        }
    }
}

// MARK: - PREVIEW

struct ReadListView_Previews: PreviewProvider {
    static var previews: some View {
        ReadListView(articles: articleData)
    }
}

class HttpGetReadArticles: ObservableObject {

    @Published var requestMade = false
    @Published var message = ""
    @Published var status = "failed"
    @Published var articles: [ArticleModel] = []

    func getArticles(user_accesstoken: String) {
        guard let url = URL(string: "http://144.202.76.74/api/v1/admin/articles/list")
        else {
            print("Request failed 1")
            return
            
        }

        let auth_pass = "Bearer " + user_accesstoken
        
          print("auth_pass:  \(auth_pass)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(auth_pass, forHTTPHeaderField: "Authorization")
        
          print("About to start request")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            print("data: \(data)")
            
            do {
                let json = try JSON(data: data)
                if let status = json["status"].string {
                  //Now you got your value
                    print("status: \(status)")
                    
                    DispatchQueue.main.async {
                        self.requestMade = true
                        self.status = status
                        if status == "success" {
                            print(status)
                            if let items = json["data"]["data"].array {
                                for item in items {
                                    if let article_type = item["article_type"].string {
                                        print(article_type)
                                    }
                                }
                            }
                            
                            /*
                            ForEach() { item in
                                articles.append(ArticleModel(
                                    articletype: "HERALD OF GLORY",
                                    title: "MRS HERALD",
                                    body: "Knowing that Mrs Mallard was in tune with herself, he tried to learn. Knowing that Mrs Mallard was in tune with herself, he tried to learn. Knowing that Mrs Mallard was in tune with herself, he tried to learn. ",
                                    image: "newtoday"
                                ))
                            }*/
                           
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
            } catch  let error as NSError {
                DispatchQueue.main.async {
                    self.requestMade = true
                    self.message = "Failed to get articles"
                    print("Request failed 3")
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

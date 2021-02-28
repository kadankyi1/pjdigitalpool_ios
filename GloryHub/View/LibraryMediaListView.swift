//
//  ReadListView.swift
//  GloryHub
//
//  Created by Shugaban Media on 16/02/2021.
//

import SwiftUI

struct LibraryMediaListView: View {
    // MARK: - PROPERTIES
    
    var articles: [ArticleModel] = articleData
    var access_token: String = getSavedString("user_accesstoken");
    @ObservedObject var model: MyModel2 = MyModel2()
    @ObservedObject var articles_http_manager = HttpGetReadArticles()
    

    // MARK: - BODY
    var body: some View {
        NavigationView {
            if articles_http_manager.requestMade {
                if (articles_http_manager.status == "success"){
                    List {
                        ForEach(articles_http_manager.received_articles) { item in
                            NavigationLink(destination: ArticleDetailView(article: item)){
                                ReadArticleRowView(article: item)
                                    .padding(.vertical, 4)
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
                    articles_http_manager.getArticles(user_accesstoken: access_token)
                })
            }
            
        } // NAVIGATION
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
        ReadListView(articles: articleData)
    }
}

class HttpGetMediaArticles: ObservableObject {

    @Published var requestMade = false
    @Published var message = ""
    @Published var status = "failed"
    @Published var received_articles: [ArticleModel] = []

    func getMedia(user_accesstoken: String) {
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
                        if let article_title = item["article_title"].string {
                            print(article_title)
                            if let article_body = item["article_body"].string {
                                print(article_body)
                                if let created_at = item["created_at"].string {
                                        print(created_at)
                                        if let article_image = item["article_image"].string {
                                            print(article_image)
                                        if let article_id = item["article_id"].int {
                                            print(article_id)
                                            var type_color = "ColorSpecialArticles"
                                            if(article_type == "HERALD OF GLORY"){
                                                type_color = "ColorArticleHeraldOfGlory"
                                            } else if(article_type == "BIBLE READING PLAN"){
                                                type_color = "ColorBibleReadingPlan"
                                            } else if(article_type == "GLORY NEWS"){
                                                type_color = "ColorGloryNews"
                                            }
                                            self.received_articles.append(ArticleModel(
                                                article_sku: article_id,
                                                articletype: article_type,
                                                title: article_title,
                                                body: article_body,
                                                image: article_image,
                                                badge_color: type_color,
                                                article_date: created_at
                                            ))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
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


//
//  ContentView.swift
//  CustomTabBarLBTA
//
//  Created by Brian Voong on 1/7/21.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().barTintColor = .systemBackground
    }
    
    @State var selectedIndex = 0
    @State var shouldShowModal = false
    
    let tabBarImageNames = ["newtoday", "newlibrary", "newread", "newlive", "newwitness"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowModal, content: {
                        Button(action: {shouldShowModal.toggle()}, label: {
                            Text("Fullscreen cover")
                        })
                    
                })
                
                switch selectedIndex {
                case 0:
                    NavigationView {
                        ScrollView {
                            ForEach(0..<100) { num in
                                Text("\(num)")
                            }
                        }
                            .navigationTitle("Today Page")
                    }
                    
                case 1:
                    ScrollView {
                        Text("Library Page")
                    }
                    
                case 2:
                    /*
                    ScrollView {
                        Text("Read Page")
                    }
                    */
                    ReadListView()
                    
                case 3:
                    ScrollView {
                        Text("Live Page")
                    }
                    
                case 4:
                    ScrollView {
                        Text("Witness Page")
                    }
                    
                default:
                    NavigationView {
                        Text("Remaining tabs")
                        
                    }
                }
                
            }
            
//            Spacer()
            
            Divider()
                .padding(.bottom, 8)
            
            HStack {
                ForEach(0..<5) { num in
                    Button(action: {
                        
                        /*
                        if num == 2 {
                            shouldShowModal.toggle()
                            return
                        }
                        */
                        
                        selectedIndex = num
                    }, label: {
                        Spacer()
                        
                        if num == 2 {
                            Image(tabBarImageNames[num])
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.red)
                        } else {
                            Image(tabBarImageNames[num])
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                        }
                        
                        
                        Spacer()
                    })
                    
                }
            }
            
            
        }
    }
}

//TabView {
//    Text("First")
//        .tabItem {
//            Image(systemName: "person")
//            Text("First")
//        }
//    Text("Second")
//        .tabItem {
//            Image(systemName: "gear")
//            Text("Second")
//        }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  LibraryView.swift
//  GloryHub
//
//  Created by Shugaban Media on 27/02/2021.
//

import SwiftUI

struct LibraryView: View {
    // MARK: -- PROPERTIES
    var body: some View {
        VStack {
            Button(action: {
                print("First button pressed")
            }, label: {
                CustomRowView(buttonTitle: "AUDIOS", buttonColor: "ColorArticleHeraldOfGlory")
            })
            .padding(.vertical, 25)
            
            Button(action: {
                print("Second button pressed")
            }, label: {
                CustomRowView(buttonTitle: "VIDEOS", buttonColor: "ColorBlueInLoggedSpace")
            })
            .padding(.vertical, 25)
            
            Button(action: {
                print("Third button pressed")
            }, label: {
                CustomRowView(buttonTitle: "FAVORITES", buttonColor: "ColorGloryNews")
            })
            .padding(.vertical, 25)

            
            Spacer()
        }
        .padding()
        
    } // BODY
}

    // MARK: -- PROPERTIES
struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}


struct CustomRowView: View {
    
    @State var buttonTitle: String
    @State var buttonColor: String
    
    var body: some View {
        Text(buttonTitle)
            .frame(maxWidth: .infinity, maxHeight: 350)
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 100, idealHeight: 100, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
            .padding(.vertical, 40)
            .background(Color(buttonColor))
            //.background(Image("Background"))
            .cornerRadius(20)
            .font(.title)
            .shadow(radius: 25)
    }
}


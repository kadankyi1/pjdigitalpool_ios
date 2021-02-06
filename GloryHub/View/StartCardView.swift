//
//  StartCardView.swift
//  GloryHub
//
//  Created by Shugaban Media on 02/02/2021.
//

import SwiftUI

struct StartCardView: View {
    // MARK: - PROPERTIES
    
    var start: StarterModel
    @State private var isAnimating: Bool = false
    @Binding var currentStage: String
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack (spacing: -70) {
                // FRUIT IMAGE
                Image(start.image)
                    .resizable()
                    .scaleEffect(x: 0.8, y: 0.8, anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    //.scaledToFit()
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
            
                // FRUIT TITLE
                Text("THAT HE MIGHT PRESENT TO HIMSELF A GLORIOUS CHURCH, NOT HAVING SPOT, OR WRINKLE, OR ANY SUCH THING; BUT THAT IT SHOULD BE HOLY AND WITHOUT BLEMISH \n-EPHESIANS 5: 27")
                    .foregroundColor(Color.white)
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 70)
                    .frame(maxWidth: 480)
                
                // FRUIT HEADLINE
            
                // BUTTON: START
                StartButtonView(currentStage: $currentStage)
                    .padding(.vertical, 35)
            } //: VSTACK
        } //: ZSTACK
        .onAppear{
            withAnimation(.easeOut(duration: 0.5)){
                isAnimating = true
            }
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(LinearGradient(gradient: Gradient(colors: [Color("ColorBlueInLoggedSpace")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
        .cornerRadius(20)
        .padding(.horizontal, 10)
    }
}

// MARK: - PREVIEW

/*
struct StartCardView_Previews: PreviewProvider {
    static var previews: some View {
        StartCardView(start: startData[1], currentStage: <#Binding<String>#>)
            .previewLayout(.fixed(width: 320, height: 640))
    }
}
 */

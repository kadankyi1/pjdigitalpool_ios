//
//  CustomProgressView.swift
//  GloryHub
//
//  Created by Shugaban Media on 10/03/2021.
//

import SwiftUI

struct CustomProgressView: View {
var body: some View {
ZStack {
ZStack {
}
.frame(width: 300, height: 6, alignment: .center)
.background(RoundedRectangle(cornerRadius: 3)
.fill(Color.blue))
ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                })
                .frame(width: 100, height: 6, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 3)
                                                .fill(Color.green))
        }
}
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}

//
//  GeometryGetter.swift
//  GloryHub
//
//  Created by Dankyi Anno Kwaku on 11/23/21.
//

import SwiftUI
import Foundation

struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { geometry in
            Group { () -> AnyView in
                DispatchQueue.main.async {
                    self.rect = geometry.frame(in: .global)
                }

                return AnyView(Color.clear)
            }
        }
    }
}

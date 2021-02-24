//
//  StarterModel.swift
//  GloryHub
//
//  Created by Shugaban Media on 03/02/2021.
//

import SwiftUI

// MARK: - FRUITS DATA MODEL

struct MediaModel: Identifiable {
    var id = UUID()
    var sku: Int
    var type: String
    var title: String
    var body: String
    var image: String
    var badge_color: String
    var date: String
    var url: String
}


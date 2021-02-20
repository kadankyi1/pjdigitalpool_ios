//
//  StarterModel.swift
//  GloryHub
//
//  Created by Shugaban Media on 03/02/2021.
//

import SwiftUI

// MARK: - FRUITS DATA MODEL

struct ArticleModel: Identifiable {
    var id = UUID()
    var article_sku: Int
    var articletype: String
    var title: String
    var body: String
    var image: String
    var badge_color: String
    var article_date: String
}


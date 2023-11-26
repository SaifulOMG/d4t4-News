//
//  Article.swift
//  d4t4 News
//
//  Created by Briteyellow on 25/11/2023.
//

import Foundation

struct Articles: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [ArticleDetail]?
    var code: String?
    var message: String?
}

struct ArticleDetail: Codable {
    var title: String?
    var author: String?
    var source: Source?
    var publishedAt: String?
    var url: String?
}

struct Source: Codable {
    var id: String?
    var name: String?
}

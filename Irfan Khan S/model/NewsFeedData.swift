//
//  NewsFeedData.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 27/01/23.
//

import Foundation


struct Person: Codable {
    var name: String
    var age: Int
    var fullName: String
}

struct NewsFeed: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source : Codable {
    let id: String?
    let name: String
}

//
//  News.swift
//  NewsApp
//
//  Created by Monalisa on 19/05/23.
//

import Foundation

struct News: Codable {
    let author: String?
    let title: String
    let description: String?
    let url: String
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey
    {
        case author
        case title
        case description
        case url
        case imageUrl = "urlToImage"
    }
}

struct NewsResponse: Codable {
    let totalResults: Int
    let articles: [News]
}

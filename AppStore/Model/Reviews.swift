//
//  Reviews.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 11/3/22.
//

import Foundation

struct Reviews: Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let title: Label
    let content: Label
    let author: Author
    
    let rating: Label
    
    enum CodingKeys: String, CodingKey {
        case author, content, title
        case rating = "im:rating"
        
    }
}

struct Author: Decodable {
    let name: Label
}

struct Label: Decodable {
    let label: String
}

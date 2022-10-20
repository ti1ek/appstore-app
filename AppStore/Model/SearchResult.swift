//
//  SearchResult.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 10/19/22.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
}

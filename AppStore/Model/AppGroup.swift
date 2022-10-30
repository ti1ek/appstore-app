//
//  AppGroup.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 10/24/22.
//

import Foundation
import UIKit

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results:[FeedResult]
}

struct FeedResult: Decodable {
    let id, artistName, name, artworkUrl100: String
}

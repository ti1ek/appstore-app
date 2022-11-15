//
//  TodayItem.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 11/10/22.
//

import Foundation
import UIKit

struct TodayItem {
    
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor 
    
    
    let cellType: CellType
    
    let apps: [FeedResult]
    
    enum CellType: String {
        case single, multiple
    }
}

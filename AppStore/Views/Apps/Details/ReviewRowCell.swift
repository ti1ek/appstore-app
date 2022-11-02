//
//  ReviewRowCell.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 11/2/22.
//

import Foundation
import UIKit

class ReviewRowCell: UICollectionViewCell {
    
    let reviewsController = ReviewsController()
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        addSubview(reviewsController.view)
        reviewsController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

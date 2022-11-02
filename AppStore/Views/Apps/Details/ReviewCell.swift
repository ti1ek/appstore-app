//
//  ReviewCell.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 11/2/22.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 16  ))
    let bodyLabel = UILabel(text: "ReviewBody\nReviewBody\nReviewBody", font: .systemFont(ofSize:  14))
    
    override init(frame:CGRect) {
        super .init(frame: frame)
        
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
        UIStackView(arrangedSubviews:  [
        titleLabel, UIView(), authorLabel
        ]),
        starsLabel,
         bodyLabel
        ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

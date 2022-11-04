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
    
    let starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach ({ (_) in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        })
        
        arrangedSubviews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews )
        return stackView
    }()
    
    let bodyLabel = UILabel(text: "ReviewBody\nReviewBody\nReviewBody", font: .systemFont(ofSize:  18), numberOfLines: 5)
    
    
    
    override init(frame:CGRect) {
        super .init(frame: frame)
        
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
        UIStackView(arrangedSubviews:  [
        titleLabel, authorLabel
        ], customSpacing: 8),
        starsStackView,
        bodyLabel
        ], spacing: 12)
        
        
        titleLabel.setContentCompressionResistancePriority(.init(rawValue: 0), for: .horizontal)
        authorLabel.textAlignment = .right
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor , padding: .init(top:  20 , left: 20, bottom: 0, right: 20))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

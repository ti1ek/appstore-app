//
//  TodayCell.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 11/6/22.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageView.image = todayItem.image
            descriptionLabel.text = todayItem.description
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 28))
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    
    let descriptionLabel = UILabel(text: "All the apps and tools you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        //clipsToBounds = true
        layer.cornerRadius = 16
        
        imageView.contentMode = .scaleAspectFill
      
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        
        let stackView = VerticalStackView(arrangedSubviews: [
        categoryLabel, titleLabel, imageContainerView, descriptionLabel
        ], spacing: 8)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        
        //addSubview(imageView)
        //imageView.centerInSuperview(size: .init(width: 200, height: 200))
        //imageView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
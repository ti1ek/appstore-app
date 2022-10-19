//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 10/18/22.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    let appIconimageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.layer.cornerRadius = 12
        image.widthAnchor.constraint(equalToConstant: 64).isActive = true
        image.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos and Videos"
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "9.25M"
        return label
    }()
    
    let getButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var screenshot1ImageView = self.createScreenshotImageView()
    lazy var screenshot2ImageView = self.createScreenshotImageView()
    lazy var screenshot3ImageView = self.createScreenshotImageView()
    
    func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let infoTopStackView = UIStackView(arrangedSubviews: [
        appIconimageView,
        VerticalStackView(arrangedSubviews: [
            nameLabel, categoryLabel, ratingLabel
        ]),
        getButton
        ])
        
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let screenshotsStackView = UIStackView(arrangedSubviews: [
        screenshot1ImageView, screenshot2ImageView,screenshot3ImageView
        ])
        screenshotsStackView.spacing = 12
        screenshotsStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubviews: [
            infoTopStackView, screenshotsStackView
        ], spacing: 16)
        
        addSubview(overallStackView)
        
        overallStackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

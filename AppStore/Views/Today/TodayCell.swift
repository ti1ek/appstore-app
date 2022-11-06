//
//  TodayCell.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 11/6/22.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 200, height: 200))
        imageView.contentMode = .scaleAspectFill 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

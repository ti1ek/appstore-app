//
//  ScreenShotCell.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 11/1/22.
//

import UIKit

class ScreenShotCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.fillSuperview()
        imageView.backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

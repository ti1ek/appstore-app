//
//  PreviewCell.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 11/1/22.
//

import UIKit

class PreviewCell: UICollectionViewCell {
    
    let horizontalController = PreviewScreenshotsController()
    
    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 25))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        addSubview(previewLabel)
        addSubview(horizontalController.view)
        
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        horizontalController.view.anchor(top: previewLabel.bottomAnchor , leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding:  .init(top: 20, left: 0, bottom: 0, right: 0) )

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

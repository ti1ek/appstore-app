//
//  BaseListController.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 10/21/22.
//

import Foundation
import UIKit

class BaseListController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

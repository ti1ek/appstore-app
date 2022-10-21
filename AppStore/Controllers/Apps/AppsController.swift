//
//  AppsController.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 10/21/22.
//

import Foundation
import UIKit

class AppsController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let identifier = "id"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = . yellow
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 250)
}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    

}

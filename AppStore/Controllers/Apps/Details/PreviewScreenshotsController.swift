//
//  PreviewScreenshotsController.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 11/1/22.
//

import UIKit

class PreviewScreenshotsController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellID"
    
    var app: Result? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(ScreenShotCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0 
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenShotCell
        let screenShotUrl = self.app?.screenshotUrls[indexPath.item]
        cell.imageView.sd_setImage(with: URL(string: screenShotUrl ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}

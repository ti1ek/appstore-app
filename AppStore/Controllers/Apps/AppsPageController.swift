//
//  AppsController.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 10/21/22.
//

import Foundation
import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerId)
        
        fetchData()
    }
    
    //   var topFreeApps: AppGroup?
    var groups = [AppGroup]()
    
    fileprivate func fetchData() {
        
        var freeGroup: AppGroup?
        var paidGroup: AppGroup?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchTopFreeApp { appGroup, error in
            dispatchGroup.leave()
            freeGroup = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopPaidApp { appGroup, error in
            dispatchGroup.leave()
            paidGroup = appGroup
    }
        dispatchGroup.notify(queue: .main) {
            if let group = freeGroup {
                self.groups.append(group)
            }
            if let group = paidGroup {
                self.groups.append(group)
            }
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        
        let appGroup = groups[indexPath.item]
        
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup =  appGroup
        cell.horizontalController.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}

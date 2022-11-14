//
//  TodayMultipleAppsController.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 11/13/22.
//

import UIKit

class TodayMultipleAppsController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var results = [FeedResult]()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close_button"), for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if mode == .fullScreen {
            setupCloseButton()
        
        } else {
            collectionView.isScrollEnabled = false
        }
        
        collectionView.backgroundColor = .white

        
        collectionView.register(MultipleAppsCell.self, forCellWithReuseIdentifier: cellId)
        
            Service.shared.fetchTopPaidApp { (appGroup,  error) in
            self.results = appGroup?.feed.results ?? []

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool { return true  }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
        if mode == .fullScreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        }
        return .zero
    }
    
    func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        closeButton.anchor(top: view.topAnchor , leading: nil, bottom: nil, trailing: view.trailingAnchor, padding:  .init(top:  20, left: 0, bottom: 0, right:16), size: .init(width:  44, height: 44 ))
    }
     
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullScreen {
            return results.count
        }
        return min(4, results.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppsCell
        cell.app = self.results[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       // let height: CGFloat = (view.frame.height - 3 * spacing)/4
        let height: CGFloat = 68
        
        if mode == .fullScreen {
            return .init(width: view.frame.width - 48, height: height)
        }
        return .init(width: view.frame.width , height: height)
    }
    
    fileprivate let spacing: CGFloat = 16
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    fileprivate let mode: Mode
    
    enum Mode {
        case small, fullScreen
    }
    
    init(mode: Mode) {
        self.mode =  mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

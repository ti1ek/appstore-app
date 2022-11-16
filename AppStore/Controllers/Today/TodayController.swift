//
//  TodayController.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 11/6/22.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "CellID"
    fileprivate let multipleAppCellId = "multipleAppCellId"
    
    var items = [TodayItem]()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
//    let items = [
//        TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the apps and tools you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single),
//        TodayItem.init(category: "THE DAILY LIST", title: "Test-Drive These CarPlay Apps", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple),
//        TodayItem.init(category: "HOLIDAYS", title: "Travel on a budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everyting!", backgroundColor: #colorLiteral(red: 0.9789130092, green: 0.9626896977, blue: 0.7274394631, alpha: 1), cellType: .single)
//    ]
//
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        
        fetchData()
        
        navigationController?.isNavigationBarHidden = true
        collectionView.backgroundColor = #colorLiteral(red: 0.9490197301, green: 0.9490197301, blue: 0.9490196109, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue )
    }
    
    fileprivate func fetchData() {
        // dispatchGroup
        
        let dispatchGroup = DispatchGroup()
        
        var topPaidGroup: AppGroup?
        var topFreeGroup: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchTopPaidApp { (appGroup, err) in
            // make sure to check your errors
            topPaidGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopFreeApp  { (appGroup, err) in
            topFreeGroup = appGroup
            dispatchGroup.leave()
        }
        
        // completion block
        dispatchGroup.notify(queue: .main) {
            // I'll have access to top grossing and games somehow
            
            print("Finished fetching")
            self.activityIndicatorView.stopAnimating()
            
            self.items = [
                TodayItem.init(category: "Daily List", title: topPaidGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topPaidGroup?.feed.results ?? []),
                
                TodayItem.init(category: "Daily List", title: topFreeGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topFreeGroup?.feed.results ?? []),
                
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), cellType: .single, apps: []),

            ]
            
            self.collectionView.reloadData()
        }
        
    }
    
    var appFullScreenController: AppFullScreenController!
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if items[indexPath.item].cellType == .multiple {
            let fullController = TodayMultipleAppsController(mode: .fullScreen)
            fullController.modalPresentationStyle = .fullScreen
            present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
            return
        }
        
        let appFullScreenController = AppFullScreenController()
        appFullScreenController.todayItem = items[indexPath.row ]
        appFullScreenController.dismissHandler = {
            self.handleRemoveRedView()
        }
        
        
        let fullScreenView = appFullScreenController.view!
        view.addSubview(fullScreenView)
        
        
        addChild(appFullScreenController)
        
        self.appFullScreenController = appFullScreenController
        
        self.collectionView.isUserInteractionEnabled = false
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach ({$0?.isActive = true})
        self.view.layoutIfNeeded()
        
        //redView.frame = startingFrame
        fullScreenView.layer.cornerRadius = 16
        
        UIView.animate(withDuration: 0.7 , delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            
            self.appFullScreenController.tableView.contentOffset = .zero
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.isHidden = true
            
            guard let cell = appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else {return}
            
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    
    var startingFrame: CGRect?
    
    @objc func handleRemoveRedView() {
        
        UIView.animate(withDuration: 0.7 , delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            // gesture.view?.frame = self.startingFrame ?? .zero
            
            guard let startingFrame = self.startingFrame else {return}
            
            
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.isHidden = false
            
            guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else {return}
            
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
            
        }, completion: {_ in
            self.appFullScreenController.view.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
            
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        
        (cell as? TodayMultipleAppCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
        return cell
    }
    
    @objc func handleMultipleAppsTap(gesture: UITapGestureRecognizer) {
        
        let collectionView = gesture.view
        
        var superView = collectionView?.superview
        
        while superView != nil {
            if let cell = superView as? TodayMultipleAppCell {
                
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                
                let apps = self.items[indexPath.item].apps
                
                let fullController = TodayMultipleAppsController(mode: .fullScreen)
                fullController.apps = apps
                present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
                return
            }
            superView = superView?.superview
        }
      
    }
    
    static let cellSize: CGFloat = 500
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayController.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}

//
//  SearchController.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 10/18/22.
//

import UIKit
import SDWebImage

class SearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let identifier = "cellData"
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    var appResults = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SearchResultCell.self,
                                forCellWithReuseIdentifier: identifier)
        
        setupSearchBar()
        
        fetchITunesApps()
    }
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: { _ in
            Service.shared.fetchApps(searchTerm: searchText) { result, error in
                self.appResults = result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }

    
    fileprivate func fetchITunesApps() {
        Service.shared.fetchApps(searchTerm: "Twitter") { (results, error) in
            
            if let error = error {
                print("Failed to fetch apps:", error)
                return
            }
            
            self.appResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SearchResultCell

        cell.appResult = appResults[indexPath.item]
        return cell
    }
}

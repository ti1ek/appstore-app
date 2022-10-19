//
//  SearchController.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 10/18/22.
//

import UIKit

class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let identifier = "cellData"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SearchResultCell.self,
                                forCellWithReuseIdentifier: identifier)
        
        fetchITunesApps()
    }
    
    fileprivate func fetchITunesApps() {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch apps", error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                searchResult.results.forEach({print($0.trackName, $0.primaryGenreName)})
            } catch let jsonError {
                print("Failed to fetch json", jsonError)
            }
        }.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SearchResultCell
        cell.nameLabel.text = "HERE IS MY APP NAME"
        return cell
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  Service.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 10/20/22.
//

import Foundation

class Service {
    static let shared = Service()
    
    func fetchApps(completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch apps", error)
                completion([], nil)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)

            } catch let jsonError {
                print("Failed to fetch json", jsonError)
                completion([], jsonError)
            }
                
        }.resume()
    }
}

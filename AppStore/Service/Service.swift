//
//  Service.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 10/20/22.
//

import Foundation

class Service {
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
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
    
    func fetchTopFreeApp(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/25/apps.json"
        
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopPaidApp(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/25/apps.json"
        
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?)-> Void) {
       
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(nil, error)
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data)
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
                print(error)
            }
        }.resume()
    }
    func fetchSocialApps(completion:  @escaping ([SocialApp]?, Error?) -> Void ) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(nil, error)
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let objects = try JSONDecoder().decode([SocialApp].self, from: data)
                completion(objects, nil)
            } catch {
                completion(nil, error)
                print(error)
            }
        }.resume()
    }
}

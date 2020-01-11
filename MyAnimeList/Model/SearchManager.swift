//
//  SearchManager.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-03.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

protocol AnimeSearchManagerDelegate {
    func didUpdateSearch(_ searchManager: SearchManager, _ search: AnimeSearchModel)
    func didFailWithError(_ error: Error)
}

struct SearchManager {
    let searchURL = "https://api.jikan.moe/v3/search"
    
    var delegate: AnimeSearchManagerDelegate?
    
    func fetchSearch(_ searchType: String, _ searchQ: String) {
        let urlString = "\(searchURL)/\(searchType)?q=\(searchQ.replacingOccurrences(of: " ", with: "%20"))"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. Create URL
        if let url = URL(string: urlString) {
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if let search = self.parseJSON(safeData) {
                        self.delegate?.didUpdateSearch(self, search)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ searchData: Data) -> AnimeSearchModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(AnimeSearchData.self, from: searchData)
            let results = decodedData.results
            
            let search = AnimeSearchModel(searchResults: results)
            
            return search
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

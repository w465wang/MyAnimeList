//
//  SearchManager.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-03.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

protocol SearchManagerDelegate {
    func didUpdateSearch(_ searchManager: SearchManager, _ search: SearchModel)
    func didFailWithError(_ error: Error)
}

struct SearchManager {
    let searchURL = "https://api.jikan.moe/v3/search"
    var delegate: SearchManagerDelegate?
    
    func fetchSearch(_ searchType: String, _ searchQ: String) {
        let urlString = "\(searchURL)/\(searchType)?q=\(searchQ.replacingOccurrences(of: " ", with: "%20"))"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if let search = self.parseJSONAnime(safeData) {
                        self.delegate?.didUpdateSearch(self, search)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSONAnime(_ searchData: Data) -> SearchModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(SearchData.self, from: searchData)
            let results = decodedData.results
            let search = SearchModel(animeSearchResults: results)
            
            return search
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

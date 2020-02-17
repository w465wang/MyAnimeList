//
//  TopManager.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-02-16.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

protocol TopManagerDelegate {
    func didUpdateTop(_ topManager: TopManager, _ top: TopModel)
    func didFailWithError(_ error: Error)
}

struct TopManager {
    let topURL = "https://api.jikan.moe/v3/top"
    var delegate: TopManagerDelegate?
    
    func fetchTop(_ topType: String, _ topPage: Int, _ topSub: String) {
        let urlString = "\(topURL)/\(topType)/\(topPage)/\(topSub)"
        print(urlString)
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
                    if let top = self.parseJSON(safeData) {
                        self.delegate?.didUpdateTop(self, top)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ topData: Data) -> TopModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(TopData.self, from: topData)

            let top = TopModel(top: decodedData.top)
            
            return top
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

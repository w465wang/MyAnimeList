//
//  MangaManager.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-18.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

protocol MangaManagerDelegate {
    func didUpdateManga(_ mangaManager: MangaManager, _ manga: MangaModel)
    func didFailWithError(_ error: Error)
}

struct MangaManager {
    let mangaURL = "https://api.jikan.moe/v3/manga"
    var delegate: MangaManagerDelegate?
    
    func fetchManga(_ mangaID: String, _ mangaRequest: String) {
        let urlString = "\(mangaURL)/\(mangaID)/\(mangaRequest)"
        print(urlString)
        performRequest(with: urlString, and: mangaRequest)
    }
    
    func performRequest(with urlString: String, and request: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if request == K.Requests.null {
                        if let manga = self.parseJSON(safeData) {
                            self.delegate?.didUpdateManga(self, manga)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ mangaData: Data) -> MangaModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(MangaData.self, from: mangaData)
            
            let title = decodedData.title
            let type = decodedData.type
            let status = decodedData.status
            let imageURL = decodedData.image_url
            
            let volumes: String
            if decodedData.volumes != nil {
                volumes = String(decodedData.volumes!)
            } else {
                volumes = "Unknown"
            }
            
            let chapters: String
            if decodedData.chapters != nil {
                chapters = String(decodedData.chapters!)
            } else {
                chapters = "Unknown"
            }
            
            let rank: String
            if decodedData.rank != nil {
                rank = String(decodedData.rank!)
            } else {
                rank = "N/A"
            }
            
            let score: String
            if decodedData.score != nil {
                score = String(format: "%.2f", decodedData.score!)
            } else {
                score = "N/A"
            }
            
            let scoredBy = String(decodedData.scored_by)
            let popularity = String(decodedData.popularity)
            let members = String(decodedData.members)
            let favorites = String(decodedData.favorites)
            
            let synopsis: String
            if decodedData.synopsis != nil {
                synopsis = decodedData.synopsis!
            } else {
                synopsis = "No synopsis information has been added to this title."
            }

            let manga = MangaModel(mangaTitle: title, mangaType: type, mangaStatus: status, mangaImageURL: imageURL, mangaVolumes: volumes, mangaChapters: chapters, mangaRank: rank, mangaScore: score, mangaScoredBy: scoredBy, mangaPopularity: popularity, mangaMembers: members, mangaFavorites: favorites, mangaSynopsis: synopsis)
            
            return manga
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

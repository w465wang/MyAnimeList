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
    func didUpdateMangaCharacter(_ mangaManager: MangaManager, _ manga: MangaCharacterModel)
    func didUpdateMangaStat(_ mangaManager: MangaManager, _ manga: MangaStatModel)
//    func didUpdateMangaUser(_ mangaManager: MangaManager, _ manga: MangaUserModel)
    func didUpdateMangaReview(_ mangaManager: MangaManager, _ manga: MangaReviewModel)
    func didUpdateMangaPicture(_ mangaManager: MangaManager, _ manga: PictureModel)
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
                    } else if request == K.Requests.characters {
                        if let manga = self.parseJSONCharacters(safeData) {
                            self.delegate?.didUpdateMangaCharacter(self, manga)
                        }
                    } else if request == K.Requests.stats {
                        if let manga = self.parseJSONStat(safeData) {
                            self.delegate?.didUpdateMangaStat(self, manga)
                        }
                    } else if request == K.Requests.reviews {
                        if let manga = self.parseJSONReview(safeData) {
                            self.delegate?.didUpdateMangaReview(self, manga)
                        }
                    } else if request == K.Requests.pictures {
                        if let manga = self.parseJSONPictures(safeData) {
                            self.delegate?.didUpdateMangaPicture(self, manga)
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
                volumes = "Volumes: \(decodedData.volumes!)"
            } else {
                volumes = "Volumes: Unknown"
            }
            
            let chapters: String
            if decodedData.chapters != nil {
                chapters = "Chapters: \(decodedData.chapters!)"
            } else {
                chapters = "Chapters: Unknown"
            }
            
            let volChap = "\(volumes), \(chapters)"
            
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
            
            let scoredBy: String
            if decodedData.scored_by != nil {
                scoredBy = String(decodedData.scored_by!)
            } else {
                scoredBy = "N/A"
            }
            
            let popularity = String(decodedData.popularity)
            let members = String(decodedData.members)
            let favorites = String(decodedData.favorites)
            
            let synopsis: String
            if decodedData.synopsis != nil {
                synopsis = decodedData.synopsis!
            } else {
                synopsis = "No synopsis information has been added to this title."
            }

            let manga = MangaModel(mangaTitle: title, mangaType: type, mangaStatus: status, mangaImageURL: imageURL, mangaVolChap: volChap, mangaRank: rank, mangaScore: score, mangaScoredBy: scoredBy, mangaPopularity: popularity, mangaMembers: members, mangaFavorites: favorites, mangaSynopsis: synopsis, mangaRelated: decodedData.related)
            
            return manga
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func parseJSONCharacters(_ mangaData: Data) -> MangaCharacterModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(MangaCharacterData.self, from: mangaData)
            let manga = MangaCharacterModel(mangaCharacters: decodedData.characters)

            return manga
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func parseJSONStat(_ mangaData: Data) -> MangaStatModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(MangaStatData.self, from: mangaData)
            let manga = MangaStatModel(mangaReading: String(decodedData.reading), mangaCompleted: String(decodedData.completed), mangaOnHold: String(decodedData.on_hold), mangaDropped: String(decodedData.dropped), mangaPlanToRead: String(decodedData.plan_to_read), mangaTotal: String(decodedData.total), mangaScores: decodedData.scores)

            return manga
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func parseJSONReview(_ mangaData: Data) -> MangaReviewModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(MangaReviewData.self, from: mangaData)
            let manga = MangaReviewModel(mangaReviews: decodedData.reviews)

            return manga
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func parseJSONPictures(_ pictureData: Data) -> PictureModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(PictureData.self, from: pictureData)

            let manga = PictureModel(pictures: decodedData.pictures)
            
            return manga
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

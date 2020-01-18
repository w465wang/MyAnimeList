//
//  AnimeManager.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-02.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

protocol AnimeManagerDelegate {
    func didUpdateAnime(_ animeManager: AnimeManager, _ anime: AnimeModel)
    func didUpdateAnimeCharacterStaff(_ animeManager: AnimeManager, _ anime: AnimeCharacterModel)
    func didUpdateAnimeStat(_ animeManager: AnimeManager, _ anime: AnimeStatModel)
    func didUpdateAnimeUser(_ animeManager: AnimeManager, _ anime: AnimeUserModel)
    func didUpdateAnimeReview(_ animeManager: AnimeManager, _ anime: AnimeReviewModel)
    func didUpdateAnimePicture(_ animeManager: AnimeManager, _ anime: PictureModel)
    func didFailWithError(_ error: Error)
}

struct AnimeManager {
    let animeURL = "https://api.jikan.moe/v3/anime"
    var delegate: AnimeManagerDelegate?
    
    func fetchAnime(_ animeID: String, _ animeRequest: String) {
        let urlString = "\(animeURL)/\(animeID)/\(animeRequest)"
        print(urlString)
        performRequest(with: urlString, and: animeRequest)
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
                        if let anime = self.parseJSON(safeData) {
                            self.delegate?.didUpdateAnime(self, anime)
                        }
                    } else if request == K.Requests.charactersStaff {
                        if let anime = self.parseJSONCharacterStaff(safeData) {
                            self.delegate?.didUpdateAnimeCharacterStaff(self, anime)
                        }
                    } else if request == K.Requests.stats {
                        if let anime = self.parseJSONStat(safeData) {
                            self.delegate?.didUpdateAnimeStat(self, anime)
                        }
                    } else if request == K.Requests.userupdates {
                        if let anime = self.parseJSONUser(safeData) {
                            self.delegate?.didUpdateAnimeUser(self, anime)
                        }
                    } else if request == K.Requests.reviews {
                        if let anime = self.parseJSONReview(safeData) {
                            self.delegate?.didUpdateAnimeReview(self, anime)
                        }
                    } else if request == K.Requests.pictures {
                        if let anime = self.parseJSONPictures(safeData) {
                            self.delegate?.didUpdateAnimePicture(self, anime)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ animeData: Data) -> AnimeModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(AnimeData.self, from: animeData)
            
            let imageURL = decodedData.image_url
            let title = decodedData.title
            let type = decodedData.type
            
            let episodes: String
            if decodedData.episodes != nil {
                if decodedData.episodes! == 1 {
                    episodes = "\(decodedData.episodes!) Episode"
                } else {
                    episodes = "\(decodedData.episodes!) Episodes"
                }
            } else {
                episodes = "Unknown"
            }
            
            let status = decodedData.status
            
            let score: String
            if decodedData.score != nil {
                score = String(format: "%.2f", decodedData.score!)
            } else {
                score = "N/A"
            }
            
            let scoredBy = String(decodedData.scored_by)
            
            let rank: String
            if decodedData.rank != nil {
                rank = String(decodedData.rank!)
            } else {
                rank = "N/A"
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
            
            let premiered: String
            if decodedData.premiered != nil {
                premiered = String(decodedData.premiered!)
            } else {
                premiered = "N/A"
            }
            
            let anime = AnimeModel(animeImageURL: imageURL, animeTitle: title, animeType: type, animeEpisodes: episodes, animeStatus: status, animeScore: score, animeScoredBy: scoredBy, animeRank: rank, animePopularity: popularity, animeMembers: members, animeFavorites: favorites, animeSynopsis: synopsis, animePremiered: premiered)
            
            return anime
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func parseJSONCharacterStaff(_ animeData: Data) -> AnimeCharacterModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(AnimeCharacterData.self, from: animeData)
            let anime = AnimeCharacterModel(animeCharacters: decodedData.characters)

            return anime
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func parseJSONStat(_ animeData: Data) -> AnimeStatModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(AnimeStatData.self, from: animeData)
            let anime = AnimeStatModel(animeWatching: String(decodedData.watching), animeCompleted: String(decodedData.completed), animeOnHold: String(decodedData.on_hold), animeDropped: String(decodedData.dropped), animePlanToWatch: String(decodedData.plan_to_watch), animeTotal: String(decodedData.total), animeScores: decodedData.scores)

            return anime
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func parseJSONUser(_ animeData: Data) -> AnimeUserModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(AnimeUserData.self, from: animeData)
            let anime = AnimeUserModel(animeUsers: decodedData.users)

            return anime
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func parseJSONReview(_ animeData: Data) -> AnimeReviewModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(AnimeReviewData.self, from: animeData)
            let anime = AnimeReviewModel(animeReviews: decodedData.reviews)

            return anime
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func parseJSONPictures(_ pictureData: Data) -> PictureModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(PictureData.self, from: pictureData)

            let character = PictureModel(pictures: decodedData.pictures)
            
            return character
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

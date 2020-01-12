//
//  PersonManager.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-12.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

protocol PersonManagerDelegate {
    func didUpdatePerson(_ personManager: PersonManager, _ person: PersonModel)
    func didUpdatePersonPicture(_ personManager: PersonManager, _ person: PictureModel)
    func didFailWithError(_ error: Error)
}

struct PersonManager {
    let personURL = "https://api.jikan.moe/v3/person"
    var delegate: PersonManagerDelegate?
    
    func fetchPerson(_ personID: String, _ personRequest: String) {
        let urlString = "\(personURL)/\(personID)/\(personRequest)"
        print(urlString)
        performRequest(with: urlString, and: personRequest)
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
                        if let person = self.parseJSON(safeData) {
                            self.delegate?.didUpdatePerson(self, person)
                        }
                    } else if request == K.Requests.pictures {
                        if let person = self.parseJSONPictures(safeData) {
                            self.delegate?.didUpdatePersonPicture(self, person)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ personData: Data) -> PersonModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(PersonData.self, from: personData)
            
            var kanji = ""
            if decodedData.given_name != nil && decodedData.family_name != nil {
                kanji = "\(decodedData.family_name!) \(decodedData.given_name!)"
            }

            let person = PersonModel(personImageURL: decodedData.image_url, personName: decodedData.name, personKanji: kanji, personAlternateNames: decodedData.alternate_names, personFavorites: String(decodedData.member_favorites), personAbout: decodedData.about ?? "", personVoice: decodedData.voice_acting_roles, personAnime: decodedData.anime_staff_positions, personManga: decodedData.published_manga)
            
            return person
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func parseJSONPictures(_ pictureData: Data) -> PictureModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(PictureData.self, from: pictureData)

            let person = PictureModel(pictures: decodedData.pictures)
            
            return person
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

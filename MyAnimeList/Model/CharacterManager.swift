//
//  CharacterManager.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-09.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

protocol CharacterManagerDelegate {
    func didUpdateSearch(_ characterManager: CharacterManager, _ character: CharacterModel)
    func didFailWithError(_ error: Error)
}

struct CharacterManager {
    let characterURL = "https://api.jikan.moe/v3/character"
    var delegate: CharacterManagerDelegate?
    
    func fetchCharacter(_ characterID: String, _ characterRequest: String) {
        let urlString = "\(characterURL)/\(characterID)/\(characterRequest)"
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
                    if let search = self.parseJSON(safeData) {
                        self.delegate?.didUpdateSearch(self, search)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ characterData: Data) -> CharacterModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CharacterData.self, from: characterData)

            let character = CharacterModel(characterName: decodedData.name, characterKanji: decodedData.name_kanji, characterNicknames: decodedData.nicknames, characterAbout: decodedData.about, characterFavorites: String(decodedData.member_favorites), characterImageURL: decodedData.image_url, characterAnimeography: decodedData.animeography, characterMangaography: decodedData.mangaography, characterVoiceActors: decodedData.voice_actors)
            
            return character
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

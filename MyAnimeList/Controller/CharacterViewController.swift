//
//  CharacterViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-09.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterViewController: UITableViewController {
    
    var characterManager = CharacterManager()
    var characterID = ""
    var animeID = ""
    var characterInfo = CharacterModel(characterName: "", characterKanji: "", characterNicknames: [], characterAbout: "", characterFavorites: "", characterImageURL: "", characterAnimeography: [], characterMangaography: [], characterVoiceActors: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterManager.delegate = self
        characterManager.fetchCharacter(characterID, K.Requests.null)
        self.showSpinner(onView: self.view)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if characterInfo.characterName != "" {
            self.removeSpinner()
            if indexPath.row == 0 {
                let cell0: CharacterImageCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.characterImage, for: indexPath) as! CharacterImageCell
                
                cell0.characterImage.kf.setImage(with: URL(string: characterInfo.characterImageURL), for: .normal)
                cell0.characterImage.imageView?.contentMode = .scaleAspectFit
                
                cell0.characterName.text = characterInfo.characterName
                cell0.characterKanji.text = characterInfo.characterKanji
                cell0.characterFavorite.text = "Member Favourites: \(characterInfo.characterFavorites)"
                
                return cell0
            } else if indexPath.row == 1 {
                let cell1: CharacterAboutCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.characterAbout, for: indexPath) as! CharacterAboutCell
                
                var nicknames = "Nicknames:"
                if characterInfo.characterNicknames.count > 0 {
                    for name in characterInfo.characterNicknames {
                        nicknames.append(" \(name),")
                    }
                    
                    nicknames.remove(at: nicknames.index(before: nicknames.endIndex))
                    nicknames.append("\n")
                } else {
                    nicknames = ""
                }
                
                cell1.title.text = "About"
                cell1.characterAbout.text = "\(nicknames)\(characterInfo.characterAbout)"
                
                return cell1
            } else if indexPath.row == 2 {
                let cell2: CharacterScrollCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.characterAnime, for: indexPath) as! CharacterScrollCell
                
                cell2.collectionTitle.text = "Animeography"
                cell2.collectionView.tag = 2
                
                return cell2
            } else if indexPath.row == 3 {
                let cell3: CharacterScrollCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.characterManga, for: indexPath) as! CharacterScrollCell
                
                cell3.collectionTitle.text = "Mangaography"
                cell3.collectionView.tag = 3
                
                return cell3
            } else if indexPath.row == 4 {
                let cell4: CharacterScrollCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.characterActor, for: indexPath) as! CharacterScrollCell
                
                cell4.collectionTitle.text = "Voice Actors"
                cell4.collectionView.tag = 4
                
                return cell4
            }
        }
        
        return UITableViewCell.init()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func characterImagePressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.characterPicture, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.characterAnime {
            let destinationVC = segue.destination as! AnimeTableViewController
            destinationVC.animeID = animeID
        } else if segue.identifier == K.Segues.characterPicture {
            let destinationVC = segue.destination as! PictureViewController
            destinationVC.type = "character"
            destinationVC.id = characterID
        }
    }
}

// MARK: - CharacterManagerDelegate

extension CharacterViewController: CharacterManagerDelegate {
    func didUpdateCharacter(_ characterManager: CharacterManager, _ character: CharacterModel) {
        characterInfo = CharacterModel(characterName: character.characterName, characterKanji: character.characterKanji, characterNicknames: character.characterNicknames, characterAbout: character.characterAbout, characterFavorites: character.characterFavorites, characterImageURL: character.characterImageURL, characterAnimeography: character.characterAnimeography, characterMangaography: character.characterMangaography, characterVoiceActors: character.characterVoiceActors)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUpdateCharacterPicture(_ characterManager: CharacterManager, _ character: PictureModel) {
        print("Not looking for pictures.")
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 2 {
            return characterInfo.characterAnimeography.count
        } else if collectionView.tag == 3 {
            return characterInfo.characterMangaography.count
        } else if collectionView.tag == 4 {
            return characterInfo.characterVoiceActors.count
        }
        
        return characterInfo.characterAnimeography.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 2 {
            let cell0: CharacterCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CellIdentifier.characterCollection, for: indexPath) as! CharacterCollectionCell
            
            cell0.image.kf.setImage(with: URL(string: characterInfo.characterAnimeography[indexPath.row].image_url))

            return cell0
        } else if collectionView.tag == 3 {
            let cell1: CharacterCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CellIdentifier.characterCollection, for: indexPath) as! CharacterCollectionCell

            cell1.image.kf.setImage(with: URL(string: characterInfo.characterMangaography[indexPath.row].image_url))

            return cell1
        } else if collectionView.tag == 4 {
            let cell2: CharacterCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CellIdentifier.characterCollection, for: indexPath) as! CharacterCollectionCell
            
            cell2.image.kf.setImage(with: URL(string: characterInfo.characterVoiceActors[indexPath.row].image_url.replacingOccurrences(of: "v.jpg", with: ".jpg")))
            
            return cell2
        }

        return UICollectionViewCell.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 2 {
            animeID = String(characterInfo.characterAnimeography[indexPath.row].mal_id)
            performSegue(withIdentifier: K.Segues.characterAnime, sender: self)
        } else {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}

//
//  CharacterListViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-04.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class CharacterListViewController: UITableViewController {
    
    @IBOutlet var characterList: UITableView!
    
    var animeCharacters: [AnimeCharacter]?
    var animeMainCharacters: [AnimeCharacter]?
    var animeSupportingCharacters: [AnimeCharacter]?
    var mangaCharacters: [MangaCharacter]?
    var mangaMainCharacters: [MangaCharacter]?
    var mangaSupportingCharacters: [MangaCharacter]?
    
    var animeManager = AnimeManager()
    var mangaManager = MangaManager()
    var animeID = ""
    var mangaID = ""
    var characterID = ""
    var personID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if animeID != "" {
            animeManager.delegate = self
            animeManager.fetchAnime(animeID, K.Requests.charactersStaff)
        } else if mangaID != "" {
            mangaManager.delegate = self
            mangaManager.fetchManga(mangaID, K.Requests.characters)
        }
        self.showSpinner(onView: self.view)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Main Characters"
        } else {
            return "Supporting Characters"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if animeID != "" {
            if section == 0 {
                return animeMainCharacters?.count ?? 1
            } else {
                return animeSupportingCharacters?.count ?? 1
            }
        } else if mangaID != "" {
            if section == 0 {
                return mangaMainCharacters?.count ?? 1
            } else {
                return mangaSupportingCharacters?.count ?? 1
            }
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterListCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.character, for: indexPath) as! CharacterListCell
        cell.delegate = self
        
        var count = 0
        if animeID != "" && animeCharacters != nil {
            if indexPath.section == 0 {
                if animeMainCharacters != nil && animeMainCharacters!.isEmpty == false {
                    cell.sourceImage.kf.setImage(with: URL(string: animeMainCharacters![indexPath.row].image_url))
                    cell.sourceName.text = animeMainCharacters![indexPath.row].name.html2String
                    
                    if animeMainCharacters![indexPath.row].voice_actors.count > 0 {
                        for actor in animeMainCharacters![indexPath.row].voice_actors {
                            if actor.language == "Japanese" {
                                cell.staffImage.kf.setImage(with: URL(string: actor.image_url.replacingOccurrences(of: "/r/23x32", with: "").replacingOccurrences(of: "/r/42x62", with: "")), for: .normal)
                                cell.staffImage.imageView?.contentMode = .scaleAspectFit
                                cell.staffName.text = actor.name
                                cell.characterID = String(actor.mal_id)
                                count += 1
                                break
                            }
                        }
                    }
                    
                    if count == 0 {
                        cell.staffImage.kf.setImage(with: URL(string: "https://opengameart.org/content/transparency-background-checkerboard"), for: .normal)
                        cell.staffImage.imageView?.contentMode = .scaleAspectFit
                        cell.staffName.text = "Unknown"
                        cell.characterID = ""
                    }
                } else {
                    cell.sourceName.text = "None found."
                }
            } else {
                if animeSupportingCharacters != nil && animeSupportingCharacters!.isEmpty == false {
                    cell.sourceImage.kf.setImage(with: URL(string: animeSupportingCharacters![indexPath.row].image_url))
                    cell.sourceName.text = animeSupportingCharacters![indexPath.row].name.html2String
                    
                    if animeSupportingCharacters![indexPath.row].voice_actors.count > 0 {
                        for actor in animeSupportingCharacters![indexPath.row].voice_actors {
                            if actor.language == "Japanese" {
                                cell.staffImage.kf.setImage(with: URL(string: actor.image_url.replacingOccurrences(of: "/r/23x32", with: "").replacingOccurrences(of: "/r/42x62", with: "")), for: .normal)
                                cell.staffImage.imageView?.contentMode = .scaleAspectFit
                                cell.staffName.text = actor.name
                                cell.characterID = String(actor.mal_id)
                                count += 1
                                break
                            }
                        }
                    }
                    
                    if count == 0 {
                        cell.staffImage.kf.setImage(with: URL(string: "https://opengameart.org/content/transparency-background-checkerboard"), for: .normal)
                        cell.staffImage.imageView?.contentMode = .scaleAspectFit
                        cell.staffName.text = "Unknown"
                        cell.characterID = ""
                    }
                } else {
                    cell.sourceName.text = "None found."
                }
            }
        } else if mangaID != "" && mangaCharacters != nil {
            if indexPath.section == 0 {
                if mangaMainCharacters != nil && mangaMainCharacters!.isEmpty == false {
                    cell.sourceImage.kf.setImage(with: URL(string: mangaMainCharacters![indexPath.row].image_url))
                    cell.sourceName.text = mangaMainCharacters![indexPath.row].name.html2String
                    cell.characterID = String(mangaMainCharacters![indexPath.row].mal_id)
                } else {
                    cell.sourceName.text = "None found."
                }
            } else {
                if mangaSupportingCharacters != nil && mangaSupportingCharacters!.isEmpty == false {
                    cell.sourceImage.kf.setImage(with: URL(string: mangaSupportingCharacters![indexPath.row].image_url))
                    cell.sourceName.text = mangaSupportingCharacters![indexPath.row].name.html2String
                    cell.characterID = String(mangaSupportingCharacters![indexPath.row].mal_id)
                } else {
                    cell.sourceName.text = "None found."
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if animeID != "" {
            if indexPath.section == 0 {
                characterID = String(animeMainCharacters![indexPath.row].mal_id)
            } else {
                characterID = String(animeSupportingCharacters![indexPath.row].mal_id)
            }
        } else if mangaID != "" {
            if indexPath.section == 0 {
                characterID = String(mangaMainCharacters![indexPath.row].mal_id)
            } else {
                characterID = String(mangaSupportingCharacters![indexPath.row].mal_id)
            }
        }
        
        performSegue(withIdentifier: K.Segues.characterListCharacter, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.characterListCharacter {
            let destinationVC = segue.destination as! CharacterViewController
            destinationVC.characterID = characterID
        } else if segue.identifier == K.Segues.characterListPerson {
            let destinationVC = segue.destination as! PersonViewController
            destinationVC.personID = personID
        }
    }
}

// MARK: - AnimeManagerDelegate

extension CharacterListViewController: AnimeManagerDelegate {
    
    func didUpdateAnime(_ animeManager: AnimeManager, _ anime: AnimeModel) {
        print("Not looking for anime.")
    }
    
    func didUpdateAnimeCharacterStaff(_ animeManager: AnimeManager, _ anime: AnimeCharacterModel) {
        self.removeSpinner()
        animeCharacters = anime.animeCharacters
        
        if animeCharacters!.isEmpty == false {
            animeMainCharacters = []
            animeSupportingCharacters = []
            
            for character in animeCharacters! {
                if character.role == "Main" {
                    animeMainCharacters?.append(character)
                } else if character.role == "Supporting" {
                    animeSupportingCharacters?.append(character)
                }
            }
            
            if animeMainCharacters!.isEmpty == true {
                animeMainCharacters = nil
            }
            if animeSupportingCharacters!.isEmpty == true {
                animeSupportingCharacters = nil
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUpdateAnimeStat(_ animeManager: AnimeManager, _ anime: AnimeStatModel) {
        print("Not looking for stats.")
    }
    
    func didUpdateAnimeUser(_ animeManager: AnimeManager, _ anime: AnimeUserModel) {
        print("Not looking for user updates.")
    }
    
    func didUpdateAnimeReview(_ animeManager: AnimeManager, _ anime: AnimeReviewModel) {
        print("Not looking for reviews.")
    }
    
    func didUpdateAnimePicture(_ animeManager: AnimeManager, _ anime: PictureModel) {
        print("Not looking for pictures.")
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

// MARK: - MangaManagerDelegate

extension CharacterListViewController: MangaManagerDelegate {
    
    func didUpdateManga(_ mangaManager: MangaManager, _ manga: MangaModel) {
        print("Not looking for manga.")
    }
    
    func didUpdateMangaCharacter(_ mangaManager: MangaManager, _ manga: MangaCharacterModel) {
        self.removeSpinner()
        mangaCharacters = manga.mangaCharacters
        
        if mangaCharacters!.isEmpty == false {
            mangaMainCharacters = []
            mangaSupportingCharacters = []
            
            for character in mangaCharacters! {
                if character.role == "Main" {
                    mangaMainCharacters?.append(character)
                } else if character.role == "Supporting" {
                    mangaSupportingCharacters?.append(character)
                }
            }
            
            if mangaMainCharacters!.isEmpty == true {
                mangaMainCharacters = nil
            }
            if mangaSupportingCharacters!.isEmpty == true {
                mangaSupportingCharacters = nil
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUpdateMangaReview(_ mangaManager: MangaManager, _ manga: MangaReviewModel) {
        print("Not looking for reviews.")
    }
    
    func didUpdateMangaPicture(_ mangaManager: MangaManager, _ manga: PictureModel) {
        print("Not looking for pictures.")
    }
}

// MARK: - CustomCellDelegate

extension CharacterListViewController: CustomCellDelegate {
    
    func callSegueFromCell(_ id: String) {
        if mangaID != "" {
            characterID = id
            performSegue(withIdentifier: K.Segues.characterListCharacter, sender: self)
        } else if id != "" {
            personID = id
            performSegue(withIdentifier: K.Segues.characterListPerson, sender: self)
        } else {
            let alertController = UIAlertController(title: "Why did you tap here?", message: "No Japanese voice actor found for this character.", preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Got it", style: .default) { (action: UIAlertAction) in })
            self.present(alertController, animated: true, completion: nil)
            
//            Where to put?
//            @objc func dismissAlertController() {
//                self.dismiss(animated: true, completion: nil)
//            }
        }
    }
}

//
//  CharacterViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-04.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class CharacterListViewController: UITableViewController {
    
    @IBOutlet var characterList: UITableView!
    
    var animeCharacters: [Character]?
    var mainCharacters: [Character]?
    var supportingCharacters: [Character]?
    
    var animeManager = AnimeManager()
    var animeID = ""
    var characterID = ""
    var personID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeManager.delegate = self
        animeManager.fetchAnime(animeID, K.Requests.charactersStaff)
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
        if section == 0 {
            return mainCharacters?.count ?? 1
        } else {
            return supportingCharacters?.count ?? 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterListCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.character, for: indexPath) as! CharacterListCell
        cell.delegate = self
        
        if animeCharacters != nil {
            var count = 0
            
            if indexPath.section == 0 {
                if mainCharacters != nil && mainCharacters!.isEmpty == false {
                    cell.characterImage.kf.setImage(with: URL(string: mainCharacters![indexPath.row].image_url))
                    cell.characterName.text = mainCharacters![indexPath.row].name.html2String
                    
                    if mainCharacters![indexPath.row].voice_actors.count > 0 {
                        for actor in mainCharacters![indexPath.row].voice_actors {
                            if actor.language == "Japanese" {
                                cell.staffImage.kf.setImage(with: URL(string: actor.image_url.replacingOccurrences(of: "/r/23x32", with: "")), for: .normal)
                                cell.staffImage.imageView?.contentMode = .scaleAspectFit
                                cell.staffName.text = actor.name
                                cell.id = String(actor.mal_id)
                                count += 1
                            }
                        }
                    }
                    
                    if count == 0 {
                        cell.staffImage.kf.setImage(with: URL(string: "https://cdn.myanimelist.net/images/questionmark_23.gif?s=f0d17be5a46f7de113f7dbbb23ae5e1a"), for: .normal)
                        cell.staffImage.imageView?.contentMode = .scaleAspectFit
                        cell.staffName.text = "Unknown"
                        cell.id = ""
                    }
                } else {
                    cell.characterName.text = "None found."
                }
            } else {
                if supportingCharacters != nil && supportingCharacters!.isEmpty == false {
                    cell.characterImage.kf.setImage(with: URL(string: supportingCharacters![indexPath.row].image_url))
                    cell.characterName.text = supportingCharacters![indexPath.row].name.html2String
                    if supportingCharacters![indexPath.row].voice_actors.count > 0 {
                        for actor in supportingCharacters![indexPath.row].voice_actors {
                            if actor.language == "Japanese" {
                                cell.staffImage.kf.setImage(with: URL(string: actor.image_url.replacingOccurrences(of: "/r/23x32", with: "")), for: .normal)
                                cell.staffImage.imageView?.contentMode = .scaleAspectFit
                                cell.staffName.text = actor.name
                                cell.id = String(actor.mal_id)
                                count += 1
                            }
                        }
                    }
                    
                    if count == 0 {
                        cell.staffImage.kf.setImage(with: URL(string: "https://cdn.myanimelist.net/images/questionmark_23.gif?s=f0d17be5a46f7de113f7dbbb23ae5e1a"), for: .normal)
                        cell.staffImage.imageView?.contentMode = .scaleAspectFit
                        cell.staffName.text = "Unknown"
                        cell.id = ""
                    }
                } else {
                    cell.characterName.text = "None found."
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            characterID = String(mainCharacters![indexPath.row].mal_id)
        } else {
            characterID = String(supportingCharacters![indexPath.row].mal_id)
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
            mainCharacters = []
            supportingCharacters = []
            
            for character in animeCharacters! {
                if character.role == "Main" {
                    mainCharacters?.append(character)
                } else if character.role == "Supporting" {
                    supportingCharacters?.append(character)
                }
            }
            
            if mainCharacters!.isEmpty == true {
                mainCharacters = nil
            }
            if supportingCharacters!.isEmpty == true {
                supportingCharacters = nil
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

// MARK: - CustomCellDelegate

extension CharacterListViewController: CustomCellDelegate {
    
    func callSegueFromCell(_ id: String) {
        if id != "" {
            personID = id
            performSegue(withIdentifier: K.Segues.characterListPerson, sender: self)
        } else {
            let alertController = UIAlertController(title: "Why did you tap here?", message: "No Japanese voice actor found for this character.", preferredStyle: .actionSheet)

            alertController.addAction(UIAlertAction(title: "Got it", style: .default) { (action:UIAlertAction) in })
            
            self.present(alertController, animated: true, completion: nil)
            
//            Where to put?
//            @objc func dismissAlertController() {
//                self.dismiss(animated: true, completion: nil)
//            }
        }
    }
}

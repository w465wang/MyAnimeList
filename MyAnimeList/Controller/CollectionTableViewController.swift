//
//  CollectionTableViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-13.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class CollectionTableViewController: UICollectionViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    var voice: [VoiceActingRole] = []
    var anime: [AnimeStaffPosition] = []
    var manga: [PublishedManga] = []
    
    var animeID = ""
    var characterID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell0: TableCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CellIdentifier.personVoice, for: indexPath) as! TableCell
            
            cell0.tableView.tag = 0
            
            return cell0
        } else if indexPath.row == 1 {
            let cell1: TableCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CellIdentifier.personAnime, for: indexPath) as! TableCell
            
            cell1.tableView.tag = 1
            
            return cell1
        } else {
            let cell2: TableCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CellIdentifier.personManga, for: indexPath) as! TableCell
            
            cell2.tableView.tag = 2
            
            return cell2
        }
    }
    
    
}

// MARK: - UICollectionViewFlowLayout

extension CollectionTableViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CollectionTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return voice.count
        } else if tableView.tag == 1 {
            return anime.count
        } else {
            return manga.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView.tag == 0 {
            return "Voice Acting Roles"
        } else if tableView.tag == 1 {
            return "Anime Staff Positions"
        } else {
            return "Published Manga"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
            let cell0: ListCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.personTable, for: indexPath) as! ListCell
            cell0.delegate = self
            
            cell0.listImageLeft.kf.setImage(with: URL(string: voice[indexPath.row].anime.image_url))
            cell0.listNameLeft.text = voice[indexPath.row].anime.name
            cell0.listImageRight.kf.setImage(with: URL(string: voice[indexPath.row].character.image_url), for: .normal)
            cell0.listImageRight.imageView?.contentMode = .scaleAspectFit
            cell0.listNameRight.text = voice[indexPath.row].character.name
            cell0.id = String(voice[indexPath.row].character.mal_id)
            
            return cell0;
        } else if tableView.tag == 1 {
            let cell1: ListCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.personTable, for: indexPath) as! ListCell
            cell1.delegate = self
            
            cell1.listImageLeft.kf.setImage(with: URL(string: anime[indexPath.row].anime.image_url))
            cell1.listNameLeft.text = anime[indexPath.row].anime.name
            cell1.listNameRight.text = anime[indexPath.row].position
            cell1.id = ""
            
            return cell1
        } else {
            let cell2: ListCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.personTable, for: indexPath) as! ListCell
            cell2.delegate = self
            
            cell2.listImageLeft.kf.setImage(with: URL(string: manga[indexPath.row].manga.image_url))
            cell2.listNameLeft.text = manga[indexPath.row].manga.name
            cell2.listNameRight.text = manga[indexPath.row].position
            cell2.id = ""
            
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 0 {
            animeID = String(voice[indexPath.row].anime.mal_id)
            performSegue(withIdentifier: K.Segues.staffAnime, sender: self)
        } else if tableView.tag == 1 {
            animeID = String(anime[indexPath.row].anime.mal_id)
            performSegue(withIdentifier: K.Segues.staffAnime, sender: self)
        } else if tableView.tag == 2 {
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.staffAnime {
            let destinationVC = segue.destination as! AnimeTableViewController
            destinationVC.animeID = animeID
        } else if segue.identifier == K.Segues.staffCharacter {
            let destinationVC = segue.destination as! CharacterViewController
            destinationVC.characterID = characterID
        }
    }
}

// MARK: - CustomCellDelegate

extension CollectionTableViewController: CustomCellDelegate {
    
    func callSegueFromCell(_ id: String) {
        if id != "" {
            characterID = id
            performSegue(withIdentifier: K.Segues.staffCharacter, sender: self)
        }
    }
}

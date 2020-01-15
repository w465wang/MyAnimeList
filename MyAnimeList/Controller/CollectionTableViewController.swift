//
//  CollectionTableViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-13.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class CollectionTableViewController: UICollectionViewController {
    
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
        return CGSize(width: view.frame.width, height: view.frame.height)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.personTable, for: indexPath)
        
        if tableView.tag == 0 {
            let cell0: CharacterListCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.personTable, for: indexPath) as! CharacterListCell
            cell0.delegate = self
            
            cell0.characterImage.kf.setImage(with: URL(string: voice[indexPath.row].anime.image_url))
            cell0.characterName.text = voice[indexPath.row].character.name
            cell0.staffImage.kf.setImage(with: URL(string: voice[indexPath.row].character.image_url), for: .normal)
            cell0.staffImage.imageView?.contentMode = .scaleAspectFit
            cell0.staffName.text = voice[indexPath.row].role
            
            cell0.id = String(voice[indexPath.row].character.mal_id)
            
            return cell0;
        } else if tableView.tag == 1 {
            cell.backgroundColor = .green
//            cell.characterImage.kf.setImage(with: URL(string: anime[indexPath.row].anime.image_url))
        } else {
            cell.backgroundColor = .blue
//            cell.characterImage.kf.setImage(with: URL(string: manga[indexPath.row].manga.image_url))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 0 {
            animeID = String(voice[indexPath.row].anime.mal_id)
            performSegue(withIdentifier: K.Segues.staffAnime, sender: self)
        } else if tableView.tag == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
        } else if tableView.tag == 2 {
            tableView.deselectRow(at: indexPath, animated: true)
        }
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

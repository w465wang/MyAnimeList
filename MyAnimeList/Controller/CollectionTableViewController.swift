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
            cell.backgroundColor = .red
        } else if tableView.tag == 1 {
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .blue
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

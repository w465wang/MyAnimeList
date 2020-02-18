//
//  RelatedViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-02-17.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class RelatedViewController: UITableViewController {
    
    var titles: [String] = []
    var related: [[Related]] = []
    var id = ""
    
    override func viewDidLoad() {
        self.showSpinner(onView: self.view)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return related.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return related[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.removeSpinner()
        
        let cell: RelatedCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.related, for: indexPath) as! RelatedCell
        
        cell.relatedName.text = "\(related[indexPath.section][indexPath.row].name) (\(related[indexPath.section][indexPath.row].type))"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id = String(related[indexPath.section][indexPath.row].mal_id)
        if related[indexPath.section][indexPath.row].type == K.SearchType.anime {
            performSegue(withIdentifier: K.Segues.relatedAnime, sender: self)
        } else if related[indexPath.section][indexPath.row].type == K.SearchType.manga {
            performSegue(withIdentifier: K.Segues.relatedManga, sender: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.relatedAnime {
            let destinationVC = segue.destination as! AnimeMangaViewController
            destinationVC.animeID = id
        } else if segue.identifier == K.Segues.relatedManga {
            let destinationVC = segue.destination as! AnimeMangaViewController
            destinationVC.mangaID = id
        }
    }
}

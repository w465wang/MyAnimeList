//
//  SearchViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-03.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit
import Kingfisher

class SearchViewController: UITableViewController {
    
    @IBOutlet var searchTable: UITableView!
    
    var userSearch: String?
    var searchType: String?
    var animeSearchResults: [AnimeResult]?
    var mangaSearchResults: [MangaResult]?
    
    var searchManager = SearchManager()
    var animeID = ""
    var mangaID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchManager.delegate = self
        searchManager.fetchSearch(searchType!, userSearch!)
        self.showSpinner(onView: self.view)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchType == K.SearchType.anime {
            if animeSearchResults == nil || animeSearchResults?.isEmpty == true {
                return 1
            } else {
                return animeSearchResults!.count
            }
        } else if searchType == K.SearchType.manga {
            if mangaSearchResults == nil || mangaSearchResults?.isEmpty == true {
                return 1
            } else {
                return mangaSearchResults!.count
            }
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.search, for: indexPath) as! ListCell
        
        if searchType == K.SearchType.anime {
            if animeSearchResults != nil && animeSearchResults!.isEmpty == false {
                cell.listImage.kf.setImage(with: URL(string: animeSearchResults![indexPath.row].image_url))
                cell.listLabel.text = animeSearchResults![indexPath.row].title
            } else if animeSearchResults?.isEmpty == true {
                let alertController = UIAlertController(title: "Search Error", message: "No search results found.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Got it", style: .default) { (action: UIAlertAction) in self.handleButton(alert: action)})
                self.present(alertController, animated: true, completion: nil)
            }
        } else if searchType == K.SearchType.manga {
            if mangaSearchResults != nil && mangaSearchResults!.isEmpty == false {
                cell.listImage.kf.setImage(with: URL(string: mangaSearchResults![indexPath.row].image_url))
                cell.listLabel.text = mangaSearchResults![indexPath.row].title
            } else if mangaSearchResults?.isEmpty == true {
                let alertController = UIAlertController(title: "Search Error", message: "No search results found.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Got it", style: .default) { (action: UIAlertAction) in self.handleButton(alert: action)})
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if animeSearchResults?.isEmpty == false {
            animeID = String(animeSearchResults![indexPath.row].mal_id)
            performSegue(withIdentifier: K.Segues.animeSelection, sender: self)
        } else if mangaSearchResults?.isEmpty == false {
            mangaID = String(mangaSearchResults![indexPath.row].mal_id)
            performSegue(withIdentifier: K.Segues.mangaSelection, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.animeSelection {
            let destinationVC = segue.destination as! AnimeMangaViewController
            destinationVC.animeID = animeID
        } else if segue.identifier == K.Segues.mangaSelection {
            let destinationVC = segue.destination as! AnimeMangaViewController
            destinationVC.mangaID = mangaID
        }
    }
    
    func handleButton(alert: UIAlertAction) {
        switch(alert.style) {
        default:
            _ = navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - SearchManagerDelegate

extension SearchViewController: SearchManagerDelegate {
    
    func didUpdateSearch(_ searchManager: SearchManager, _ search: SearchModel) {
        self.removeSpinner()
        animeSearchResults = search.animeSearchResults
        mangaSearchResults = search.mangaSearchResults
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}


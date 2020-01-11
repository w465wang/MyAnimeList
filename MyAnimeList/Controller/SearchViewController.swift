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
    var searchResults: [AnimeResult]?
    
    var searchManager = SearchManager()
    var animeID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchManager.delegate = self
        searchManager.fetchSearch(K.SearchType.anime, userSearch!)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.search, for: indexPath) as! SearchCell
        
        if searchResults != nil {
            cell.searchImage.kf.setImage(with: URL(string: searchResults![indexPath.row].image_url))
            cell.searchLabel.text = searchResults![indexPath.row].title
        } else {
            cell.searchLabel.text = K.LoadingMessage.search
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchResults != nil {
            animeID = String(searchResults![indexPath.row].mal_id)
            performSegue(withIdentifier: K.Segues.selection, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.selection {
            let destinationVC = segue.destination as! AnimeViewController
            destinationVC.animeID = animeID
        }
    }
}

// MARK: - SearchManagerDelegate

extension SearchViewController: SearchManagerDelegate {
    
    func didUpdateSearch(_ searchManager: SearchManager, _ search: SearchModel) {
        searchResults = search.animeSearchResults
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}


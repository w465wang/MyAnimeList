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
        self.showSpinner(onView: self.view)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults == nil || searchResults?.isEmpty == true {
            return 1
        } else {
            return searchResults!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.search, for: indexPath) as! SearchCell
        
        if searchResults != nil && searchResults!.isEmpty == false {
            cell.searchImage.kf.setImage(with: URL(string: searchResults![indexPath.row].image_url))
            cell.searchLabel.text = searchResults![indexPath.row].title
        } else if searchResults?.isEmpty == true {
            let alertController = UIAlertController(title: "Search Error", message: "No search results found.", preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: "Got it", style: .default) { (action: UIAlertAction) in self.handleButton(alert: action)})
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchResults?.isEmpty == false {
            animeID = String(searchResults![indexPath.row].mal_id)
            performSegue(withIdentifier: K.Segues.selection, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.selection {
            let destinationVC = segue.destination as! AnimeTableViewController
            destinationVC.animeID = animeID
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
        searchResults = search.animeSearchResults
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}


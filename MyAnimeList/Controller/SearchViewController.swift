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
    var searchSource: [AnimeResult]?
    
    var searchManager = SearchManager()
    var animeID = ""
    var limit = 10
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchManager.delegate = self
        searchManager.fetchSearch(K.SearchType.anime, userSearch!)
        self.showSpinner(onView: self.view)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSource?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.search, for: indexPath) as! SearchCell
        
        if searchResults != nil && searchResults!.isEmpty == false {
            cell.searchImage.kf.setImage(with: URL(string: searchResults![indexPath.row].image_url))
            cell.searchLabel.text = searchResults![indexPath.row].title
        } else if searchResults != nil && searchResults!.isEmpty == true {
            cell.searchLabel.text = "No results found."
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if searchResults != nil && searchSource != nil {
            if indexPath.row == searchResults!.count - 1 {
                spinner.stopAnimating()
            } else if indexPath.row == searchSource!.count - 1 {
                if searchSource!.count < searchResults!.count {
                    var index = searchSource!.count
                    limit = index + 10
                    
                    if limit > searchResults!.count {
                        limit = searchResults!.count
                    }
                    
                    while index < limit {
                        searchSource!.append(searchResults![index])
                        index += 1
                    }
                    
                    self.perform(#selector(loadTable), with: nil, afterDelay: 0.5)
                }
            }
        }
    }
    
    @objc func loadTable() {
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchResults != nil {
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
}

// MARK: - SearchManagerDelegate

extension SearchViewController: SearchManagerDelegate {
    
    func didUpdateSearch(_ searchManager: SearchManager, _ search: SearchModel) {
        self.removeSpinner()
        searchResults = search.animeSearchResults

        if searchResults!.isEmpty == false {
            searchSource = []
            for i in 0...min(9, searchResults!.count - 1) {
                searchSource?.append(searchResults![i])
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}


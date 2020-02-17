//
//  HomeViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-03.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var userSearch: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topButton.contentHorizontalAlignment = .left
        if self.title! == K.VCTitle.animeHome {
            topButton.setTitle("Top Anime", for: .normal)
        } else if self.title! == K.VCTitle.mangaHome {
            topButton.setTitle("Top Manga", for: .normal)
        }
        
        searchBar.delegate = self
    }
    
    @IBAction func topPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.animeTop, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.animeSearch {
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.userSearch = userSearch
            destinationVC.searchType = K.SearchType.anime
        } else if segue.identifier == K.Segues.animeTop {
            let destinationVC = segue.destination as! TopViewController
            destinationVC.topType = K.SearchType.anime
        } else if segue.identifier == K.Segues.mangaSearch {
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.userSearch = userSearch
            destinationVC.searchType = K.SearchType.manga
        } else if segue.identifier == K.Segues.mangaTop {
            let destinationVC = segue.destination as! TopViewController
            destinationVC.topType = K.SearchType.manga
        }
    }
}

// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            if text.count >= 3 {
                userSearch = text
                
                if self.title! == K.VCTitle.animeHome {
                    performSegue(withIdentifier: K.Segues.animeSearch, sender: self)
                } else if self.title! == K.VCTitle.mangaHome {
                    performSegue(withIdentifier: K.Segues.mangaSearch, sender: self)
                }
            } else {
                let alertController = UIAlertController(title: "Search Error", message: "Must enter at least three characters to perform search.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Got it", style: .default) { (action: UIAlertAction) in })
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

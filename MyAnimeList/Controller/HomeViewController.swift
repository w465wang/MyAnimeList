//
//  HomeViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-03.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var topAnime: UIButton!
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
        
        topAnime.contentHorizontalAlignment = .left
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.search {
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.userSearch = userSearch
        }
    }
}

// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            if text.count >= 3 {
                userSearch = text
                performSegue(withIdentifier: K.Segues.search, sender: self)
            } else {
                let alertController = UIAlertController(title: "Search Error", message: "Must enter at least three characters to perform search.", preferredStyle: .alert)

                alertController.addAction(UIAlertAction(title: "Got it", style: .default) { (action: UIAlertAction) in })
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

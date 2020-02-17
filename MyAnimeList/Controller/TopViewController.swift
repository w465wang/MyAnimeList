//
//  TopViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-02-16.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class TopViewController: UITableViewController {

    var topType = ""
    var topAnimeInfo: [TopAnime]?
    
    var topManager = TopManager()
    var animeID = ""
    var mangaID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topManager.delegate = self
        topManager.fetchTop(topType, 1, K.Requests.null)
        
        self.showSpinner(onView: self.view)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.top, for: indexPath) as! ListCell
        
        if topAnimeInfo != nil && topAnimeInfo?.isEmpty != true {
            let episodes: String
            if topAnimeInfo![indexPath.row].episodes != nil {
                episodes = String(topAnimeInfo![indexPath.row].episodes!)
            } else {
                episodes = "-"
            }
            
            cell.listImage.kf.setImage(with: URL(string: topAnimeInfo![indexPath.row].image_url))
            cell.listLabel.text = "\(topAnimeInfo![indexPath.row].title)"
            cell.listSubLabel.text = "\(topAnimeInfo![indexPath.row].type) (\(episodes) eps)\nScore: \(String(format: "%.2f", topAnimeInfo![indexPath.row].score))"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if topAnimeInfo?.isEmpty != true {
            animeID = String(topAnimeInfo![indexPath.row].mal_id)
            performSegue(withIdentifier: K.Segues.topAnime, sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.topAnime {
            let destinationVC = segue.destination as! AnimeMangaViewController
            destinationVC.animeID = animeID
        } else if segue.identifier == K.Segues.topManga {
            
        }
    }

}

// MARK: - TopManagerDelegate

extension TopViewController: TopManagerDelegate {
    
    func didUpdateTop(_ topManager: TopManager, _ top: TopModel) {
        self.removeSpinner()
        topAnimeInfo = top.top
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

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
    var topInfo: [TopAnimeManga]?
    
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
        
        let startDate: String
        let endDate: String
        if topInfo != nil && topInfo?.isEmpty != true {
            if topInfo![indexPath.row].start_date != nil {
                startDate = topInfo![indexPath.row].start_date!
            } else {
                startDate = ""
            }
            if topInfo![indexPath.row].end_date != nil {
                endDate = topInfo![indexPath.row].end_date!
            } else {
                endDate = ""
            }
            
            cell.listImage.kf.setImage(with: URL(string: topInfo![indexPath.row].image_url))
            cell.listLabel.text = "\(topInfo![indexPath.row].title) (\(topInfo![indexPath.row].type))"
            cell.listSubLabel.text = "\(startDate) - \(endDate)\nScore: \(String(format: "%.2f", topInfo![indexPath.row].score))"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if topType == K.SearchType.anime {
            animeID = String(topInfo![indexPath.row].mal_id)
            performSegue(withIdentifier: K.Segues.topAnime, sender: self)
        } else if topType == K.SearchType.manga {
            mangaID = String(topInfo![indexPath.row].mal_id)
            performSegue(withIdentifier: K.Segues.topManga, sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.topAnime {
            let destinationVC = segue.destination as! AnimeMangaViewController
            destinationVC.animeID = animeID
        } else if segue.identifier == K.Segues.topManga {
            let destinationVC = segue.destination as! AnimeMangaViewController
            destinationVC.mangaID = mangaID
        }
    }
}

// MARK: - TopManagerDelegate

extension TopViewController: TopManagerDelegate {
    
    func didUpdateTop(_ topManager: TopManager, _ top: TopModel) {
        self.removeSpinner()
        topInfo = top.top
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

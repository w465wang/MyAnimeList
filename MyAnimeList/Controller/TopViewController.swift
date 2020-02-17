//
//  TopViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-02-16.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class TopViewController: UITableViewController {

    @IBOutlet weak var navBar: UINavigationItem!
    
    var topType = ""
    var topSubType = ""
    var topInfo: [TopAnimeManga] = []
    var page = 1;
    
    var topManager = TopManager()
    var animeID = ""
    var mangaID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if topType == K.SearchType.anime {
            if topSubType == K.Requests.null {
                navBar.title = "Top Anime"
            } else if topSubType == K.Requests.popularity {
                navBar.title = "Popular Anime"
            }
        } else if topType == K.SearchType.manga {
            if topSubType == K.Requests.null {
                navBar.title = "Top Manga"
            } else if topSubType == K.Requests.popularity {
                navBar.title = "Popular Manga"
            }
        }
        
        topManager.delegate = self
        topManager.fetchTop(topType, page, topSubType)
        
        self.showSpinner(onView: self.view)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return page * 50
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.top, for: indexPath) as! ListCell
        
        let startDate: String
        let endDate: String
        if topInfo.isEmpty != true {
            if indexPath.row == (page - 1) * 50 && page < 200 {
                page += 1
                topManager.fetchTop(topType, page, topSubType)
            }
            
            if topInfo[indexPath.row].start_date != nil {
                startDate = topInfo[indexPath.row].start_date!
            } else {
                startDate = ""
            }
            if topInfo[indexPath.row].end_date != nil {
                endDate = topInfo[indexPath.row].end_date!
            } else {
                endDate = ""
            }
            
            cell.listImage.kf.setImage(with: URL(string: topInfo[indexPath.row].image_url))
            cell.listLabel.text = "\(indexPath.row + 1). \(topInfo[indexPath.row].title) (\(topInfo[indexPath.row].type))"
            if topSubType == K.Requests.null {
                cell.listSubLabel.text = "\(startDate) - \(endDate)\nScore: \(String(format: "%.2f", topInfo[indexPath.row].score))"
            } else if topSubType == K.Requests.popularity {
                cell.listSubLabel.text = "\(startDate) - \(endDate)\nMembers: \(topInfo[indexPath.row].members)"
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if topType == K.SearchType.anime {
            animeID = String(topInfo[indexPath.row].mal_id)
            performSegue(withIdentifier: K.Segues.topAnime, sender: self)
        } else if topType == K.SearchType.manga {
            mangaID = String(topInfo[indexPath.row].mal_id)
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

        for item in top.top {
            topInfo.append(item)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

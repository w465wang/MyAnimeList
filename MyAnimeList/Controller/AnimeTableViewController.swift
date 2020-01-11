//
//  AnimeTableViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-08.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit
import UIImageColors

class AnimeTableViewController: UITableViewController {
    
    @IBOutlet var animeTable: UITableView!
    
    var animeManager = AnimeManager()
    var animeID = ""
    var animeInfo = AnimeModel(animeImageURL: "", animeTitle: "", animeType: "", animeEpisodes: "", animeStatus: "", animeScore: "", animeScoredBy: "", animeRank: "", animePopularity: "", animeMembers: "", animeFavorites: "", animeSynopsis: "", animePremiered: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeManager.delegate = self
        animeManager.fetchAnime(animeID, K.Requests.null)
        self.showSpinner(onView: self.view)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if animeInfo.animeImageURL != "" {
            self.removeSpinner()
            
            if indexPath.row == 0 {
                let cell0: AnimeImageCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.animeImage, for: indexPath) as! AnimeImageCell
                
                cell0.animeImage.kf.setImage(with: URL(string: animeInfo.animeImageURL))
                cell0.animeTitle.text = animeInfo.animeTitle
                if Int(animeInfo.animeEpisodes) == 1 {
                    cell0.animeEpisodes.text = "\(animeInfo.animeEpisodes) Episode"
                } else {
                    cell0.animeEpisodes.text = "\(animeInfo.animeEpisodes) Episodes"
                }
                cell0.animeTypePremiered.text = "(\(animeInfo.animeType), \(animeInfo.animePremiered))"
                cell0.animeStatus.text = animeInfo.animeStatus
                       
                return cell0
            } else if indexPath.row == 1 {
                let cell1: AnimeSynopsisCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.animeSynopsis, for: indexPath) as! AnimeSynopsisCell
                
                cell1.animeSynopsis.text = animeInfo.animeSynopsis
                
                return cell1
            } else if indexPath.row == 2 {
                let cell2 = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.animeInfo, for: indexPath) as! AnimeInfoCell
                
                cell2.animeScore.text = "Score: \(animeInfo.animeScore)"
                cell2.animeScoredBy.text = "Scored By: \(animeInfo.animeScoredBy)"
                cell2.animeRank.text = "Rank: \(animeInfo.animeRank)"
                cell2.animePopularity.text = "Popularity: \(animeInfo.animePopularity)"
                cell2.animeMembers.text = "Members: \(animeInfo.animeMembers)"
                cell2.animeFavorites.text = "Favourites: \(animeInfo.animeFavorites)"
                
                return cell2
            } else if indexPath.row == 3 {
                let cell3 = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.animeCharacterStaff, for: indexPath) as! ButtonCell
                
                return cell3
            } else if indexPath.row == 4 {
                let cell4 = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.animeStats, for: indexPath) as! ButtonCell
                
                return cell4
            } else if indexPath.row == 5 {
                let cell5 = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.animeReviews, for: indexPath) as! ButtonCell
                
                return cell5
            }
        }
        
        return UITableViewCell.init()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let cell: AnimeSynopsisCell = tableView.cellForRow(at: indexPath) as! AnimeSynopsisCell
            
            if cell.animeSynopsis.numberOfLines == 3 {
                cell.animeSynopsis.numberOfLines = 0
            } else {
                cell.animeSynopsis.numberOfLines = 3
            }
            
            self.tableView.reloadData()
        } else if indexPath.row == 3 {
            performSegue(withIdentifier: K.Segues.characterList, sender: self)
        } else if indexPath.row == 4 {
            performSegue(withIdentifier: K.Segues.stat, sender: self)
        } else if indexPath.row == 5 {
            performSegue(withIdentifier: K.Segues.review, sender: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.characterList {
            let destinationVC = segue.destination as! CharacterStaffViewController
            destinationVC.animeID = animeID
        } else if segue.identifier == K.Segues.stat {
            let destinationVC = segue.destination as! StatViewController
            destinationVC.animeID = animeID
        } else if segue.identifier == K.Segues.review {
            let destinationVC = segue.destination as! ReviewViewController
            destinationVC.animeID = animeID
        }
    }
}

// MARK: - AnimeManagerDelegate

extension AnimeTableViewController: AnimeManagerDelegate {
    
    func didUpdateAnime(_ animeManager: AnimeManager, _ anime: AnimeModel) {
        animeInfo = AnimeModel(animeImageURL: anime.animeImageURL, animeTitle: anime.animeTitle, animeType: anime.animeType, animeEpisodes: anime.animeEpisodes, animeStatus: anime.animeStatus, animeScore: anime.animeScore, animeScoredBy: anime.animeScoredBy, animeRank: anime.animeRank, animePopularity: anime.animePopularity, animeMembers: anime.animeMembers, animeFavorites: anime.animeFavorites, animeSynopsis: anime.animeSynopsis, animePremiered: anime.animePremiered)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUpdateAnimeCharacterStaff(_ animeManager: AnimeManager, _ anime: AnimeCharacterModel) {
        print("Not looking for characters and staff.")
    }
    
    func didUpdateAnimeStat(_ animeManager: AnimeManager, _ anime: AnimeStatModel) {
        print("Not looking for stats.")
    }
    
    func didUpdateAnimeReview(_ animeManager: AnimeManager, _ anime: AnimeReviewModel) {
        print("Not looking for reviews.")
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//
//  AnimeStatViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-10.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class StatViewController: UITableViewController {
    
    var animeManager = AnimeManager()
    var animeID = ""
    var statInfo = AnimeStatModel(animeWatching: "", animeCompleted: "", animeOnHold: "", animeDropped: "", animePlanToWatch: "", animeTotal: "", animeScores: [String: Score]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeManager.delegate = self
        animeManager.fetchAnime(animeID, K.Requests.stats)
        self.showSpinner(onView: self.view)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Summary"
        } else if section == 1 {
            return "Scores"
        } else {
            return "Recent User Updates"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else if section == 1 {
            return 10
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.stat, for: indexPath) as! StatCell
        
        if statInfo.animeWatching != "" {
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    cell.statLabel.text = "Watching: \(statInfo.animeWatching)"
                } else if indexPath.row == 1 {
                    cell.statLabel.text = "Completed: \(statInfo.animeCompleted)"
                } else if indexPath.row == 2 {
                    cell.statLabel.text = "On-Hold: \(statInfo.animeOnHold)"
                } else if indexPath.row == 3 {
                    cell.statLabel.text = "Dropped: \(statInfo.animeDropped)"
                } else if indexPath.row == 4 {
                    cell.statLabel.text = "Plan to Watch: \(statInfo.animePlanToWatch)"
                } else if indexPath.row == 5 {
                    cell.statLabel.text = "Total: \(statInfo.animeTotal)"
                }
            } else if indexPath.section == 1 {
                if indexPath.row == 0 {
                    cell.statLabel.text = "10: \(String(format: "%.1f", statInfo.animeScores["10"]!.percentage))% (\(statInfo.animeScores["10"]!.votes) votes)"
                } else if indexPath.row == 1 {
                    cell.statLabel.text = "9: \(String(format: "%.1f", statInfo.animeScores["9"]!.percentage))% (\(statInfo.animeScores["9"]!.votes) votes)"
                } else if indexPath.row == 2 {
                    cell.statLabel.text = "8: \(String(format: "%.1f", statInfo.animeScores["8"]!.percentage))% (\(statInfo.animeScores["8"]!.votes) votes)"
                } else if indexPath.row == 3 {
                    cell.statLabel.text = "7: \(String(format: "%.1f", statInfo.animeScores["7"]!.percentage))% (\(statInfo.animeScores["7"]!.votes) votes)"
                } else if indexPath.row == 4 {
                    cell.statLabel.text = "6: \(String(format: "%.1f", statInfo.animeScores["6"]!.percentage))% (\(statInfo.animeScores["6"]!.votes) votes)"
                } else if indexPath.row == 5 {
                    cell.statLabel.text = "5: \(String(format: "%.1f", statInfo.animeScores["5"]!.percentage))% (\(statInfo.animeScores["5"]!.votes) votes)"
                } else if indexPath.row == 6 {
                    cell.statLabel.text = "4: \(String(format: "%.1f", statInfo.animeScores["4"]!.percentage))% (\(statInfo.animeScores["4"]!.votes) votes)"
                } else if indexPath.row == 7 {
                    cell.statLabel.text = "3: \(String(format: "%.1f", statInfo.animeScores["3"]!.percentage))% (\(statInfo.animeScores["3"]!.votes) votes)"
                } else if indexPath.row == 8 {
                    cell.statLabel.text = "2: \(String(format: "%.1f", statInfo.animeScores["2"]!.percentage))% (\(statInfo.animeScores["2"]!.votes) votes)"
                } else if indexPath.row == 9 {
                    cell.statLabel.text = "1: \(String(format: "%.1f", statInfo.animeScores["1"]!.percentage))% (\(statInfo.animeScores["1"]!.votes) votes)"
                }
            } else {
                cell.statLabel.text = "TBD"
            }
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - AnimeManagerDelegate

extension StatViewController: AnimeManagerDelegate {
    
    func didUpdateAnime(_ animeManager: AnimeManager, _ anime: AnimeModel) {
        print("Not looking for null.")
    }
    
    func didUpdateAnimeCharacterStaff(_ animeManager: AnimeManager, _ anime: AnimeCharacterModel) {
        print("Not looking for characters and staff.")
    }
    
    func didUpdateAnimeStat(_ animeManager: AnimeManager, _ anime: AnimeStatModel) {
        self.removeSpinner()
        statInfo = AnimeStatModel(animeWatching: anime.animeWatching, animeCompleted: anime.animeCompleted, animeOnHold: anime.animeOnHold, animeDropped: anime.animeDropped, animePlanToWatch: anime.animePlanToWatch, animeTotal: anime.animeTotal, animeScores: anime.animeScores)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUpdateAnimeReview(_ animeManager: AnimeManager, _ anime: AnimeReviewModel) {
        print("Not looking for reviews.")
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

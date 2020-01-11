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
    var userInfo: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeManager.delegate = self
        animeManager.fetchAnime(animeID, K.Requests.stats)
        animeManager.fetchAnime(animeID, K.Requests.userupdates)
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
            if userInfo != nil {
                return 20
            } else {
                return 1
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 120
        } else {
            return 61
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell0: StatCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.stat, for: indexPath) as! StatCell
            
            if statInfo.animeWatching != "" {
                if indexPath.row == 0 {
                    cell0.statLabel.text = "Watching: \(statInfo.animeWatching)"
                } else if indexPath.row == 1 {
                    cell0.statLabel.text = "Completed: \(statInfo.animeCompleted)"
                } else if indexPath.row == 2 {
                    cell0.statLabel.text = "On-Hold: \(statInfo.animeOnHold)"
                } else if indexPath.row == 3 {
                    cell0.statLabel.text = "Dropped: \(statInfo.animeDropped)"
                } else if indexPath.row == 4 {
                    cell0.statLabel.text = "Plan to Watch: \(statInfo.animePlanToWatch)"
                } else if indexPath.row == 5 {
                    cell0.statLabel.text = "Total: \(statInfo.animeTotal)"
                }
            }
            
            return cell0
        } else if indexPath.section == 1 {
            let cell1: StatCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.stat, for: indexPath) as! StatCell
            
            if statInfo.animeWatching != "" {
                if indexPath.row == 0 {
                    cell1.statLabel.text = "10: \(String(format: "%.1f", statInfo.animeScores["10"]!.percentage))% (\(statInfo.animeScores["10"]!.votes) votes)"
                } else if indexPath.row == 1 {
                    cell1.statLabel.text = "9: \(String(format: "%.1f", statInfo.animeScores["9"]!.percentage))% (\(statInfo.animeScores["9"]!.votes) votes)"
                } else if indexPath.row == 2 {
                    cell1.statLabel.text = "8: \(String(format: "%.1f", statInfo.animeScores["8"]!.percentage))% (\(statInfo.animeScores["8"]!.votes) votes)"
                } else if indexPath.row == 3 {
                    cell1.statLabel.text = "7: \(String(format: "%.1f", statInfo.animeScores["7"]!.percentage))% (\(statInfo.animeScores["7"]!.votes) votes)"
                } else if indexPath.row == 4 {
                    cell1.statLabel.text = "6: \(String(format: "%.1f", statInfo.animeScores["6"]!.percentage))% (\(statInfo.animeScores["6"]!.votes) votes)"
                } else if indexPath.row == 5 {
                    cell1.statLabel.text = "5: \(String(format: "%.1f", statInfo.animeScores["5"]!.percentage))% (\(statInfo.animeScores["5"]!.votes) votes)"
                } else if indexPath.row == 6 {
                    cell1.statLabel.text = "4: \(String(format: "%.1f", statInfo.animeScores["4"]!.percentage))% (\(statInfo.animeScores["4"]!.votes) votes)"
                } else if indexPath.row == 7 {
                    cell1.statLabel.text = "3: \(String(format: "%.1f", statInfo.animeScores["3"]!.percentage))% (\(statInfo.animeScores["3"]!.votes) votes)"
                } else if indexPath.row == 8 {
                    cell1.statLabel.text = "2: \(String(format: "%.1f", statInfo.animeScores["2"]!.percentage))% (\(statInfo.animeScores["2"]!.votes) votes)"
                } else if indexPath.row == 9 {
                    cell1.statLabel.text = "1: \(String(format: "%.1f", statInfo.animeScores["1"]!.percentage))% (\(statInfo.animeScores["1"]!.votes) votes)"
                }
            }
            
            return cell1
        } else if indexPath.section == 2 {
            let cell2: UserCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.user, for: indexPath) as! UserCell
            
            if userInfo != nil {
                var score: String
                if userInfo![indexPath.row].score != nil {
                    score = String(userInfo![indexPath.row].score!)
                } else {
                    score = "-"
                }
                var seen: String
                if userInfo![indexPath.row].episodes_seen != nil {
                    seen = String(userInfo![indexPath.row].episodes_seen!)
                } else {
                    seen = "-"
                }
                var total: String
                if userInfo![indexPath.row].episodes_total != nil {
                    total = String(userInfo![indexPath.row].episodes_total!)
                } else {
                    total = "-"
                }
                
                cell2.userImage.kf.setImage(with: URL(string: userInfo![indexPath.row].image_url))
                cell2.username.text = "\(userInfo![indexPath.row].username)"
                cell2.userScore.text = "Score: \(score)"
                cell2.userStatus.text = "Status: \(userInfo![indexPath.row].status)"
                cell2.userEpsSeen.text = "Seen: \(seen)/\(total)"
            }
            
            return cell2
        }
        
        return StatCell.init()
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
    
    func didUpdateAnimeUser(_ animeManager: AnimeManager, _ anime: AnimeUserModel) {
        userInfo = anime.animeUsers
        
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

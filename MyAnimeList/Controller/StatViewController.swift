//
//  StatViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-10.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class StatViewController: UITableViewController {
    
    var animeManager = AnimeManager()
    var mangaManager = MangaManager()
    var animeID = ""
    var mangaID = ""
    
    var animeStatInfo = AnimeStatModel(animeWatching: "", animeCompleted: "", animeOnHold: "", animeDropped: "", animePlanToWatch: "", animeTotal: "", animeScores: [String: Score]())
    var mangaStatInfo = MangaStatModel(mangaReading: "", mangaCompleted: "", mangaOnHold: "", mangaDropped: "", mangaPlanToRead: "", mangaTotal: "", mangaScores: [String: Score]())
    var userInfo: [AnimeUser]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if animeID != "" {
            animeManager.delegate = self
            animeManager.fetchAnime(animeID, K.Requests.stats)
            animeManager.fetchAnime(animeID, K.Requests.userupdates)
        } else if mangaID != "" {
            mangaManager.delegate = self
            mangaManager.fetchManga(mangaID, K.Requests.stats)
//            mangaManager.fetchManga(mangaID, K.Requests.userupdates)
        }
        
        self.showSpinner(onView: self.view)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if animeID != "" {
            return 3
        }
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Summary"
        } else if section == 1 {
            return "Score Distribution"
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
            if userInfo != nil && userInfo!.isEmpty == false {
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
            
            if animeID != "" && animeStatInfo.animeWatching != "" {
                if indexPath.row == 0 {
                    cell0.statLabel.text = "Watching: \(animeStatInfo.animeWatching)"
                } else if indexPath.row == 1 {
                    cell0.statLabel.text = "Completed: \(animeStatInfo.animeCompleted)"
                } else if indexPath.row == 2 {
                    cell0.statLabel.text = "On-Hold: \(animeStatInfo.animeOnHold)"
                } else if indexPath.row == 3 {
                    cell0.statLabel.text = "Dropped: \(animeStatInfo.animeDropped)"
                } else if indexPath.row == 4 {
                    cell0.statLabel.text = "Plan to Watch: \(animeStatInfo.animePlanToWatch)"
                } else if indexPath.row == 5 {
                    cell0.statLabel.text = "Total: \(animeStatInfo.animeTotal)"
                }
            } else if mangaID != "" && mangaStatInfo.mangaReading != "" {
                if indexPath.row == 0 {
                    cell0.statLabel.text = "Reading: \(mangaStatInfo.mangaReading)"
                } else if indexPath.row == 1 {
                    cell0.statLabel.text = "Completed: \(mangaStatInfo.mangaCompleted)"
                } else if indexPath.row == 2 {
                    cell0.statLabel.text = "On-Hold: \(mangaStatInfo.mangaOnHold)"
                } else if indexPath.row == 3 {
                    cell0.statLabel.text = "Dropped: \(mangaStatInfo.mangaDropped)"
                } else if indexPath.row == 4 {
                    cell0.statLabel.text = "Plan to Read: \(mangaStatInfo.mangaPlanToRead)"
                } else if indexPath.row == 5 {
                    cell0.statLabel.text = "Total: \(mangaStatInfo.mangaTotal)"
                }
            }
            
            return cell0
        } else if indexPath.section == 1 {
            let cell1: StatCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.stat, for: indexPath) as! StatCell
            
            if animeID != "" && animeStatInfo.animeWatching != "" {
                if indexPath.row == 0 {
                    cell1.statLabel.text = "10: \(String(format: "%.1f", animeStatInfo.animeScores["10"]!.percentage))% (\(animeStatInfo.animeScores["10"]!.votes) votes)"
                } else if indexPath.row == 1 {
                    cell1.statLabel.text = "9: \(String(format: "%.1f", animeStatInfo.animeScores["9"]!.percentage))% (\(animeStatInfo.animeScores["9"]!.votes) votes)"
                } else if indexPath.row == 2 {
                    cell1.statLabel.text = "8: \(String(format: "%.1f", animeStatInfo.animeScores["8"]!.percentage))% (\(animeStatInfo.animeScores["8"]!.votes) votes)"
                } else if indexPath.row == 3 {
                    cell1.statLabel.text = "7: \(String(format: "%.1f", animeStatInfo.animeScores["7"]!.percentage))% (\(animeStatInfo.animeScores["7"]!.votes) votes)"
                } else if indexPath.row == 4 {
                    cell1.statLabel.text = "6: \(String(format: "%.1f", animeStatInfo.animeScores["6"]!.percentage))% (\(animeStatInfo.animeScores["6"]!.votes) votes)"
                } else if indexPath.row == 5 {
                    cell1.statLabel.text = "5: \(String(format: "%.1f", animeStatInfo.animeScores["5"]!.percentage))% (\(animeStatInfo.animeScores["5"]!.votes) votes)"
                } else if indexPath.row == 6 {
                    cell1.statLabel.text = "4: \(String(format: "%.1f", animeStatInfo.animeScores["4"]!.percentage))% (\(animeStatInfo.animeScores["4"]!.votes) votes)"
                } else if indexPath.row == 7 {
                    cell1.statLabel.text = "3: \(String(format: "%.1f", animeStatInfo.animeScores["3"]!.percentage))% (\(animeStatInfo.animeScores["3"]!.votes) votes)"
                } else if indexPath.row == 8 {
                    cell1.statLabel.text = "2: \(String(format: "%.1f", animeStatInfo.animeScores["2"]!.percentage))% (\(animeStatInfo.animeScores["2"]!.votes) votes)"
                } else if indexPath.row == 9 {
                    cell1.statLabel.text = "1: \(String(format: "%.1f", animeStatInfo.animeScores["1"]!.percentage))% (\(animeStatInfo.animeScores["1"]!.votes) votes)"
                }
            } else if mangaID != "" && mangaStatInfo.mangaReading != "" {
                if indexPath.row == 0 {
                    cell1.statLabel.text = "10: \(String(format: "%.1f", mangaStatInfo.mangaScores["10"]!.percentage))% (\(mangaStatInfo.mangaScores["10"]!.votes) votes)"
                } else if indexPath.row == 1 {
                    cell1.statLabel.text = "9: \(String(format: "%.1f", mangaStatInfo.mangaScores["9"]!.percentage))% (\(mangaStatInfo.mangaScores["9"]!.votes) votes)"
                } else if indexPath.row == 2 {
                    cell1.statLabel.text = "8: \(String(format: "%.1f", mangaStatInfo.mangaScores["8"]!.percentage))% (\(mangaStatInfo.mangaScores["8"]!.votes) votes)"
                } else if indexPath.row == 3 {
                    cell1.statLabel.text = "7: \(String(format: "%.1f", mangaStatInfo.mangaScores["7"]!.percentage))% (\(mangaStatInfo.mangaScores["7"]!.votes) votes)"
                } else if indexPath.row == 4 {
                    cell1.statLabel.text = "6: \(String(format: "%.1f", mangaStatInfo.mangaScores["6"]!.percentage))% (\(mangaStatInfo.mangaScores["6"]!.votes) votes)"
                } else if indexPath.row == 5 {
                    cell1.statLabel.text = "5: \(String(format: "%.1f", mangaStatInfo.mangaScores["5"]!.percentage))% (\(mangaStatInfo.mangaScores["5"]!.votes) votes)"
                } else if indexPath.row == 6 {
                    cell1.statLabel.text = "4: \(String(format: "%.1f", mangaStatInfo.mangaScores["4"]!.percentage))% (\(mangaStatInfo.mangaScores["4"]!.votes) votes)"
                } else if indexPath.row == 7 {
                    cell1.statLabel.text = "3: \(String(format: "%.1f", mangaStatInfo.mangaScores["3"]!.percentage))% (\(mangaStatInfo.mangaScores["3"]!.votes) votes)"
                } else if indexPath.row == 8 {
                    cell1.statLabel.text = "2: \(String(format: "%.1f", mangaStatInfo.mangaScores["2"]!.percentage))% (\(mangaStatInfo.mangaScores["2"]!.votes) votes)"
                } else if indexPath.row == 9 {
                    cell1.statLabel.text = "1: \(String(format: "%.1f", mangaStatInfo.mangaScores["1"]!.percentage))% (\(mangaStatInfo.mangaScores["1"]!.votes) votes)"
                }
            }
            
            return cell1
        } else if indexPath.section == 2 {
            let cell2: UserCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.user, for: indexPath) as! UserCell
            
            if userInfo != nil {
                if userInfo!.count > 0 {
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
                    
                    cell2.userImage.kf.setImage(with: URL(string: userInfo![indexPath.row].image_url), for: .normal)
                    cell2.userImage.imageView?.contentMode = .scaleAspectFit
                    cell2.username.text = "\(userInfo![indexPath.row].username)"
                    cell2.userScore.text = "Score: \(score)"
                    cell2.userStatus.text = "Status: \(userInfo![indexPath.row].status)"
                    cell2.userEpsSeen.text = "Seen: \(seen)/\(total)"
                } else {
                    cell2.userScore.text = "No updates found."
                }
            } else {
                cell2.userScore.text = "Tap to reload."
            }
            
            return cell2
        }
        
        return StatCell.init()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if animeID != "" && userInfo == nil {
                animeManager.fetchAnime(animeID, K.Requests.userupdates)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - AnimeManagerDelegate

extension StatViewController: AnimeManagerDelegate {
    
    func didUpdateAnime(_ animeManager: AnimeManager, _ anime: AnimeModel) {
        print("Not looking for anime.")
    }
    
    func didUpdateAnimeCharacterStaff(_ animeManager: AnimeManager, _ anime: AnimeCharacterModel) {
        print("Not looking for characters and staff.")
    }
    
    func didUpdateAnimeStat(_ animeManager: AnimeManager, _ anime: AnimeStatModel) {
        self.removeSpinner()
        animeStatInfo = AnimeStatModel(animeWatching: anime.animeWatching, animeCompleted: anime.animeCompleted, animeOnHold: anime.animeOnHold, animeDropped: anime.animeDropped, animePlanToWatch: anime.animePlanToWatch, animeTotal: anime.animeTotal, animeScores: anime.animeScores)
        
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
    
    func didUpdateAnimePicture(_ animeManager: AnimeManager, _ anime: PictureModel) {
        print("Not looking for pictures.")
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

// MARK: - MangaManagerDelegate

extension StatViewController: MangaManagerDelegate {
    
    func didUpdateManga(_ mangaManager: MangaManager, _ manga: MangaModel) {
        print("Not looking for manga.")
    }
    
    func didUpdateMangaCharacter(_ mangaManager: MangaManager, _ manga: MangaCharacterModel) {
        print("Not looking for characters.")
    }
    
    func didUpdateMangaStat(_ mangaManager: MangaManager, _ manga: MangaStatModel) {
        self.removeSpinner()
        mangaStatInfo = MangaStatModel(mangaReading: manga.mangaReading, mangaCompleted: manga.mangaCompleted, mangaOnHold: manga.mangaOnHold, mangaDropped: manga.mangaDropped, mangaPlanToRead: manga.mangaPlanToRead, mangaTotal: manga.mangaTotal, mangaScores: manga.mangaScores)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUpdateMangaReview(_ mangaManager: MangaManager, _ manga: MangaReviewModel) {
        print("Not looking for reviews.")
    }
    
    func didUpdateMangaPicture(_ mangaManager: MangaManager, _ manga: PictureModel) {
        print("Not looking for pictures.")
    }
}

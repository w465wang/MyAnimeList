//
//  AnimeMangaViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-08.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit
import UIImageColors

class AnimeMangaViewController: UITableViewController {
    
    var animeManager = AnimeManager()
    var animeID = ""
    var animeInfo = AnimeModel(animeImageURL: "", animeTitle: "", animeType: "", animeEpisodes: "", animeStatus: "", animeScore: "", animeScoredBy: "", animeRank: "", animePopularity: "", animeMembers: "", animeFavorites: "", animeSynopsis: "", animePremiered: "")
    
    var mangaManager = MangaManager()
    var mangaID = ""
    var mangaInfo = MangaModel(mangaTitle: "", mangaType: "", mangaStatus: "", mangaImageURL: "", mangaVolChap: "", mangaRank: "", mangaScore: "", mangaScoredBy: "", mangaPopularity: "", mangaMembers: "", mangaFavorites: "", mangaSynopsis: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if animeID != "" {
            animeManager.delegate = self
            animeManager.fetchAnime(animeID, K.Requests.null)
        } else if mangaID != "" {
            mangaManager.delegate = self
            mangaManager.fetchManga(mangaID, K.Requests.null)
        }
        
        self.showSpinner(onView: self.view)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if animeInfo.animeImageURL != "" || mangaInfo.mangaImageURL != "" {
            self.removeSpinner()
            
            if indexPath.row == 0 {
                let cell0: AnimeImageCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.animeImage, for: indexPath) as! AnimeImageCell
                
                if animeID != "" {
                    cell0.animeImage.kf.setImage(with: URL(string: animeInfo.animeImageURL), for: .normal)
                    cell0.animeImage.imageView?.contentMode = .scaleAspectFit
                    
                    cell0.animeTitle.text = animeInfo.animeTitle
                    cell0.animeEpisodes.text = animeInfo.animeEpisodes
                    cell0.animeTypePremiered.text = "(\(animeInfo.animeType), \(animeInfo.animePremiered))"
                    cell0.animeStatus.text = animeInfo.animeStatus
                } else if mangaID != "" {
                    cell0.animeImage.kf.setImage(with: URL(string: mangaInfo.mangaImageURL), for: .normal)
                    cell0.animeImage.imageView?.contentMode = .scaleAspectFit
                    
                    cell0.animeTitle.text = mangaInfo.mangaTitle
                    cell0.animeEpisodes.text = mangaInfo.mangaVolChap
                    cell0.animeTypePremiered.text = mangaInfo.mangaType
                    cell0.animeStatus.text = mangaInfo.mangaStatus
                }
                       
                return cell0
            } else if indexPath.row == 1 {
                let cell1: AnimeSynopsisCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.animeSynopsis, for: indexPath) as! AnimeSynopsisCell
                
                if animeID != "" {
                    cell1.animeSynopsis.text = animeInfo.animeSynopsis
                } else if mangaID != "" {
                    cell1.animeSynopsis.text = mangaInfo.mangaSynopsis
                }
                
                return cell1
            } else if indexPath.row == 2 {
                let cell2 = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.animeInfo, for: indexPath) as! AnimeInfoCell
                
                if animeID != "" {
                    cell2.animeScore.text = "Score: \(animeInfo.animeScore)"
                    cell2.animeScoredBy.text = "Scored By: \(animeInfo.animeScoredBy)"
                    cell2.animeRank.text = "Rank: \(animeInfo.animeRank)"
                    cell2.animePopularity.text = "Popularity: \(animeInfo.animePopularity)"
                    cell2.animeMembers.text = "Members: \(animeInfo.animeMembers)"
                    cell2.animeFavorites.text = "Favourites: \(animeInfo.animeFavorites)"
                } else if mangaID != "" {
                    cell2.animeScore.text = "Score: \(mangaInfo.mangaScore)"
                    cell2.animeScoredBy.text = "Scored By: \(mangaInfo.mangaScoredBy)"
                    cell2.animeRank.text = "Rank: \(mangaInfo.mangaRank)"
                    cell2.animePopularity.text = "Popularity: \(mangaInfo.mangaPopularity)"
                    cell2.animeMembers.text = "Members: \(mangaInfo.mangaMembers)"
                    cell2.animeFavorites.text = "Favourites: \(mangaInfo.mangaFavorites)"
                }
                
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
    
    @IBAction func animeImagePressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.animePicture, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.characterList {
            let destinationVC = segue.destination as! CharacterListViewController
            
            if animeID != "" {
                destinationVC.animeID = animeID
            } else if mangaID != "" {
                destinationVC.mangaID = mangaID
            }
        } else if segue.identifier == K.Segues.stat {
            let destinationVC = segue.destination as! StatViewController
            
            if animeID != "" {
                destinationVC.animeID = animeID
            } else if mangaID != "" {
                
            }
        } else if segue.identifier == K.Segues.review {
            let destinationVC = segue.destination as! ReviewViewController
            
            if animeID != "" {
                destinationVC.animeID = animeID
            } else if mangaID != "" {
                
            }
        } else if segue.identifier == K.Segues.animePicture {
            let destinationVC = segue.destination as! PictureViewController
            
            if animeID != "" {
                destinationVC.type = K.SearchType.anime
                destinationVC.id = animeID
            } else if mangaID != "" {
                destinationVC.type = K.SearchType.manga
                destinationVC.id = mangaID
            }
        }
    }
}

// MARK: - AnimeManagerDelegate

extension AnimeMangaViewController: AnimeManagerDelegate {
    
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
    
    func didUpdateAnimeUser(_ animeManager: AnimeManager, _ anime: AnimeUserModel) {
        print("Not looking for user updates.")
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

extension AnimeMangaViewController: MangaManagerDelegate {
    
    func didUpdateManga(_ mangaManager: MangaManager, _ manga: MangaModel) {
        mangaInfo = MangaModel(mangaTitle: manga.mangaTitle, mangaType: manga.mangaType, mangaStatus: manga.mangaStatus, mangaImageURL: manga.mangaImageURL, mangaVolChap: manga.mangaVolChap, mangaRank: manga.mangaRank, mangaScore: manga.mangaScore, mangaScoredBy: manga.mangaScoredBy, mangaPopularity: manga.mangaPopularity, mangaMembers: manga.mangaMembers, mangaFavorites: manga.mangaFavorites, mangaSynopsis: manga.mangaSynopsis)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUpdateMangaCharacter(_ mangaManager: MangaManager, _ manga: MangaCharacterModel) {
        print("Not looking for characters.")
    }
    
    func didUpdateMangaPicture(_ mangaManager: MangaManager, _ manga: PictureModel) {
        print("Not looking for pictures.")
    }
}

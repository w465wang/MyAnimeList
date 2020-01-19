//
//  ReviewViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-06.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class ReviewViewController: UITableViewController {
    
    @IBOutlet var reviewTable: UITableView!
    var animeReviews: [AnimeReview]?
    var mangaReviews: [MangaReview]?
    
    var animeManager = AnimeManager()
    var mangaManager = MangaManager()
    var animeID = ""
    var mangaID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if animeID != "" {
            animeManager.delegate = self
            animeManager.fetchAnime(animeID, K.Requests.reviews)
        } else if mangaID != "" {
            mangaManager.delegate = self
            mangaManager.fetchManga(mangaID, K.Requests.reviews)
        }
        
        self.showSpinner(onView: self.view)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if animeReviews != nil && animeReviews!.isEmpty == true {
            return 1
        } else if mangaReviews != nil && mangaReviews!.isEmpty == true {
            return 1
        }
        
        if animeID != "" {
            return animeReviews?.count ?? 1
        } else if mangaID != "" {
            return mangaReviews?.count ?? 1
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.review, for: indexPath) as! ReviewCell

        if animeID != "" && animeReviews != nil {
            if animeReviews!.isEmpty == false {
                cell.reviewImage.kf.setImage(with: URL(string: animeReviews![indexPath.row].reviewer.image_url), for: .normal)
                cell.reviewImage.imageView?.contentMode = .scaleAspectFit
                
                cell.reviewUsername.text = "Username: \(animeReviews![indexPath.row].reviewer.username)"
                
                cell.reviewScore.setAttributedTitle(NSAttributedString(string: "Score: \(animeReviews![indexPath.row].reviewer.scores.overall)", attributes:
                    [.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
                cell.reviewScore.contentHorizontalAlignment = .left
                
                cell.reviewEpisodesSeen.text = "Episodes Seen: \(animeReviews![indexPath.row].reviewer.episodes_seen)"
                cell.reviewHelpfulCount.text = "Helpful Count: \(animeReviews![indexPath.row].helpful_count)"
                cell.reviewContent.text = animeReviews![indexPath.row].content.replacingOccurrences(of: "\\n", with: "\n")
            } else if animeReviews!.isEmpty == true {
                cell.reviewUsername.text = "No reviews found."
            }
        } else if mangaID != "" && mangaReviews != nil {
            if mangaReviews!.isEmpty == false {
                cell.reviewImage.kf.setImage(with: URL(string: mangaReviews![indexPath.row].reviewer.image_url), for: .normal)
                cell.reviewImage.imageView?.contentMode = .scaleAspectFit
                
                cell.reviewUsername.text = "Username: \(mangaReviews![indexPath.row].reviewer.username)"
                
                cell.reviewScore.setAttributedTitle(NSAttributedString(string: "Score: \(mangaReviews![indexPath.row].reviewer.scores.overall)", attributes:
                    [.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
                cell.reviewScore.contentHorizontalAlignment = .left
                
                cell.reviewEpisodesSeen.text = "Chapters Read: \(mangaReviews![indexPath.row].reviewer.chapters_read)"
                cell.reviewHelpfulCount.text = "Helpful Count: \(mangaReviews![indexPath.row].helpful_count)"
                cell.reviewContent.text = mangaReviews![indexPath.row].content.replacingOccurrences(of: "\\n", with: "\n")
            } else if mangaReviews!.isEmpty == true {
                cell.reviewUsername.text = "No reviews found."
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: ReviewCell = tableView.cellForRow(at: indexPath) as! ReviewCell
        
        if cell.reviewContent.numberOfLines == 3 {
            cell.reviewContent.numberOfLines = 0
        } else {
            cell.reviewContent.numberOfLines = 3
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadData()
    }
}

// MARK: - AnimeManagerDelegate

extension ReviewViewController: AnimeManagerDelegate {
    
    func didUpdateAnime(_ animeManager: AnimeManager, _ anime: AnimeModel) {
        print("Not looking for anime.")
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
        self.removeSpinner()
        animeReviews = anime.animeReviews
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUpdateAnimePicture(_ animeManager: AnimeManager, _ anime: PictureModel) {
        print("Not looking for pictures.")
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

// MARK: - MangaManagerDelegate

extension ReviewViewController: MangaManagerDelegate {
    
    func didUpdateManga(_ mangaManager: MangaManager, _ manga: MangaModel) {
        print("Not looking for manga.")
    }
    
    func didUpdateMangaCharacter(_ mangaManager: MangaManager, _ manga: MangaCharacterModel) {
        print("Not looking for characters.")
    }
    
    func didUpdateMangaReview(_ mangaManager: MangaManager, _ manga: MangaReviewModel) {
        self.removeSpinner()
        mangaReviews = manga.mangaReviews
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUpdateMangaPicture(_ mangaManager: MangaManager, _ manga: PictureModel) {
        print("Not looking for pictures.")
    }
}

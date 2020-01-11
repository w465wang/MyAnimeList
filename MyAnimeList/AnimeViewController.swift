////
////  ViewController.swift
////  MyAnimeList
////
////  Created by William Wang on 2020-01-01.
////  Copyright © 2020 William Wang. All rights reserved.
////
//
//import UIKit
//import Kingfisher
//import UIImageColors
//
//class AnimeViewController: UIViewController {
//
//    @IBOutlet weak var animeImage: UIImageView!
//    @IBOutlet weak var animeCharacters: UIButton!
//    @IBOutlet weak var animeStats: UIButton!
//    @IBOutlet weak var animeReviews: UIButton!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var typeLabel: UILabel!
//    @IBOutlet weak var episodeLabel: UILabel!
//    @IBOutlet weak var scoreLabel: UILabel!
//    @IBOutlet weak var scoredByLabel: UILabel!
//    @IBOutlet weak var rankLabel: UILabel!
//    @IBOutlet weak var popularityLabel: UILabel!
//    @IBOutlet weak var membersLabel: UILabel!
//    @IBOutlet weak var favoritesLabel: UILabel!
//
//    var animeManager = AnimeManager()
//    var animeID = ""
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        animeManager.delegate = self
//        animeManager.fetchAnime(animeID, K.AnimeRequests.null)
//    }
//
//    @IBAction func charactersPressed(_ sender: UIButton) {
//        performSegue(withIdentifier: K.Segues.characterList, sender: self)
//    }
//
//    @IBAction func statsPressed(_ sender: UIButton) {
//        performSegue(withIdentifier: K.Segues.stat, sender: self)
//    }
//
//    @IBAction func reviewsPressed(_ sender: UIButton) {
//        performSegue(withIdentifier: K.Segues.review, sender: self)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == K.Segues.characterList {
//            let destinationVC = segue.destination as! CharacterStaffViewController
//            destinationVC.animeID = animeID
//        } else if segue.identifier == K.Segues.stat {
//
//        } else if segue.identifier == K.Segues.review {
//            let destinationVC = segue.destination as! ReviewViewController
//            destinationVC.animeID = animeID
//        }
//    }
//}
//
//// MARK: - AnimeManagerDelegate
//
//extension AnimeViewController: AnimeManagerDelegate {
//
//    func didUpdateAnime(_ animeManager: AnimeManager, _ anime: AnimeModel) {
//        DispatchQueue.main.async {
//
//            let downloader = ImageDownloader.default
//            downloader.downloadImage(with: URL(string: anime.animeImageURL)!, options: []) { result in
//
//                switch result {
//                case .success(let value):
//
//                    self.animeImage.image = value.image
//                    let colors = value.image.getColors(quality: UIImageColorsQuality.highest)
//                    self.view.backgroundColor = colors?.background
//
//                    self.animeCharacters.setTitleColor(colors?.secondary, for: .normal)
////                    self.animeCharacters.backgroundColor = colors?.detail
//                    self.animeCharacters.layer.borderColor = colors?.detail.cgColor
//                    self.animeCharacters.layer.borderWidth = 1
//                    self.animeCharacters.layer.cornerRadius = 20.0
//                    self.animeStats.setTitleColor(colors?.secondary, for: .normal)
////                    self.animeStats.backgroundColor = colors?.detail
//                    self.animeStats.layer.borderColor = colors?.detail.cgColor
//                    self.animeStats.layer.borderWidth = 1
//                    self.animeStats.layer.cornerRadius = 20.0
//                    self.animeReviews.setTitleColor(colors?.secondary, for: .normal)
////                    self.animeReviews.backgroundColor = colors?.detail
//                    self.animeReviews.layer.borderColor = colors?.detail.cgColor
//                    self.animeReviews.layer.borderWidth = 1
//                    self.animeReviews.layer.cornerRadius = 20.0
//
//                    self.titleLabel.text = "\(anime.animeTitle)"
//                    self.titleLabel.textColor = colors?.detail
//                    self.typeLabel.text = "Type: \(anime.animeType)"
//                    self.typeLabel.textColor = colors?.primary
//                    self.episodeLabel.text = "Episodes: \(anime.animeEpisodes)"
//                    self.episodeLabel.textColor = colors?.primary
//                    self.scoreLabel.text = "Score: \(anime.animeScore)"
//                    self.scoreLabel.textColor = colors?.primary
//                    self.scoredByLabel.text = "Scored By: \(anime.animeScoredBy)"
//                    self.scoredByLabel.textColor = colors?.primary
//                    self.rankLabel.text = "Rank: \(anime.animeRank)"
//                    self.rankLabel.textColor = colors?.primary
//                    self.popularityLabel.text = "Popularity: \(anime.animePopularity)"
//                    self.popularityLabel.textColor = colors?.primary
//                    self.membersLabel.text = "Members: \(anime.animeMembers)"
//                    self.membersLabel.textColor = colors?.primary
//                    self.favoritesLabel.text = "Favourites: \(anime.animeFavorites)"
//                    self.favoritesLabel.textColor = colors?.primary
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//    }
//
//    func didUpdateAnimeCharacterStaff(_ animeManager: AnimeManager, _ anime: AnimeCharacterModel) {
//        print("Not looking for characters and staff.")
//    }
//
//    func didUpdateAnimeStat(_ animeManager: AnimeManager, _ anime: AnimeStatModel) {
//        print("Not looking for stats")
//    }
//
//    func didUpdateAnimeReview(_ animeManager: AnimeManager, _ anime: AnimeReviewModel) {
//        print("Not looking for reviews.")
//    }
//
//    func didFailWithError(_ error: Error) {
//        print(error)
//    }
//}

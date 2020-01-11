//
//  AnimeReviewViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-06.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class ReviewViewController: UITableViewController {
    
    @IBOutlet var reviewTable: UITableView!
    var reviews: [Review]?
    var reviewSource: [Review]?
    
    var animeManager = AnimeManager()
    var animeID = ""
    var limit = 5
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeManager.delegate = self
        animeManager.fetchAnime(animeID, K.Requests.reviews)
        self.showSpinner(onView: self.view)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewSource?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.review, for: indexPath) as! ReviewCell
        
        if reviews != nil {
            if reviews!.isEmpty == false {
                cell.reviewImage.kf.setImage(with: URL(string: reviews![indexPath.row].reviewer.image_url), for: .normal)
                cell.reviewImage.imageView?.contentMode = .scaleAspectFit
                
                cell.reviewUsername.text = "Username: \(reviews![indexPath.row].reviewer.username)"
                
                cell.reviewScore.setAttributedTitle(NSAttributedString(string: "Score: \(reviews![indexPath.row].reviewer.scores.overall)", attributes:
                    [.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
                cell.reviewScore.contentHorizontalAlignment = .left
                
                cell.reviewEpisodesSeen.text = "Episodes Seen: \(reviews![indexPath.row].reviewer.episodes_seen)"
                cell.reviewHelpfulCount.text = "Helpful Count: \(reviews![indexPath.row].helpful_count)"
                cell.reviewContent.text = reviews![indexPath.row].content.replacingOccurrences(of: "\\n", with: "\n")
            } else if reviews!.isEmpty == true {
                cell.reviewUsername.text = "No reviews found."
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if reviews != nil && reviewSource != nil {
            if indexPath.row == reviews!.count - 1 {
                spinner.stopAnimating()
            } else if indexPath.row == reviewSource!.count - 1 {
                if reviewSource!.count < reviews!.count {
                    var index = reviewSource!.count
                    limit = index + 5
                    
                    if limit > reviews!.count {
                        limit = reviews!.count
                    }
                    
                    while index < limit {
                        reviewSource!.append(reviews![index])
                        index += 1
                    }
                    
                    self.perform(#selector(loadTable), with: nil, afterDelay: 0.5)
                }
            }
        }
    }
    
    @objc func loadTable() {
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
        
        self.tableView.reloadData()
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
        print("Not looking for null.")
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
        reviews = anime.animeReviews
        
        if reviews!.isEmpty == false {
            reviewSource = []
            for i in 0...min(4, reviews!.count - 1) {
                reviewSource?.append(reviews![i])
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

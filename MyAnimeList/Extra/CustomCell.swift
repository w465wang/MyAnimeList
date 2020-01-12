//
//  CustomCell.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-03.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
}

class AnimeImageCell: UITableViewCell {
    @IBOutlet weak var animeImage: UIButton!
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var animeTypePremiered: UILabel!
    @IBOutlet weak var animeEpisodes: UILabel!
    @IBOutlet weak var animeStatus: UILabel!
}

class AnimeSynopsisCell: UITableViewCell {
    @IBOutlet weak var animeSynopsis: UILabel!
}

class AnimeInfoCell: UITableViewCell {
    @IBOutlet weak var animeScore: UILabel!
    @IBOutlet weak var animeScoredBy: UILabel!
    @IBOutlet weak var animeRank: UILabel!
    @IBOutlet weak var animePopularity: UILabel!
    @IBOutlet weak var animeMembers: UILabel!
    @IBOutlet weak var animeFavorites: UILabel!
}

class ButtonCell: UITableViewCell {
    @IBOutlet weak var buttonName: UILabel!
    @IBOutlet weak var buttonImage: UIButton!
}

class CharacterCell: UITableViewCell {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var staffImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var staffName: UILabel!
}

class StatCell: UITableViewCell {
    @IBOutlet weak var statLabel: UILabel!
}

class UserCell: UITableViewCell {
    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var userStatus: UILabel!
    @IBOutlet weak var userEpsSeen: UILabel!
}

class ReviewCell: UITableViewCell {
    @IBOutlet weak var reviewImage: UIButton!
    @IBOutlet weak var reviewUsername: UILabel!
    @IBOutlet weak var reviewScore: UIButton!
    @IBOutlet weak var reviewEpisodesSeen: UILabel!
    @IBOutlet weak var reviewHelpfulCount: UILabel!
    @IBOutlet weak var reviewContent: UILabel!
}

class PictureCell: UICollectionViewCell {
    @IBOutlet weak var picture: UIImageView!
}

class CharacterImageCell: UITableViewCell {
    @IBOutlet weak var characterImage: UIButton!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterKanji: UILabel!
    @IBOutlet weak var characterFavorite: UILabel!
}

class CharacterAboutCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var characterAbout: UILabel!
}

class CharacterScrollCell: UITableViewCell {
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate <D: UICollectionViewDelegate & UICollectionViewDataSource> (_ dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
    }
}

class CharacterCollectionCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var role: UILabel!
}

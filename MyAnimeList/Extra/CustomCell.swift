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

class ReviewCell: UITableViewCell {
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var reviewUsername: UILabel!
    @IBOutlet weak var reviewScore: UILabel!
    @IBOutlet weak var reviewEpisodesSeen: UILabel!
    @IBOutlet weak var reviewHelpfulCount: UILabel!
}

//
//  AnimeModel.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-02.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation
import UIImageColors

struct AnimeModel {
    let animeImageURL: String
    let animeTitle: String
    let animeType: String
    let animeEpisodes: String
    let animeStatus: String
    let animeScore: String
    let animeScoredBy: String
    let animeRank: String
    let animePopularity: String
    let animeMembers: String
    let animeFavorites: String
    let animeSynopsis: String
    let animePremiered: String
//    let animeColors: UIImageColors?
}

// MARK: - Characters

struct AnimeCharacterModel {
    let animeCharacters: [Character]
}

// MARK: - Stats

struct AnimeStatModel {
    let animeWatching: String
    let animeCompleted: String
    let animeOnHold: String
    let animeDropped: String
    let animePlanToWatch: String
    let animeTotal: String
    let animeScores: [String: Score]
}

// MARK: - Reviews

struct AnimeReviewModel {
    let animeReviews: [Review]
}

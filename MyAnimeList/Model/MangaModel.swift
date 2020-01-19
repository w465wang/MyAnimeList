//
//  MangaModel.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-18.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

struct MangaModel {
    let mangaTitle: String
    let mangaType: String
    let mangaStatus: String
    let mangaImageURL: String
    let mangaVolChap: String
    let mangaRank: String
    let mangaScore: String
    let mangaScoredBy: String
    let mangaPopularity: String
    let mangaMembers: String
    let mangaFavorites: String
    let mangaSynopsis: String
}

// MARK: - Characters

struct MangaCharacterModel {
    let mangaCharacters: [MangaCharacter]
}

// MARK: - Stats

struct MangaStatModel: Codable {
    let mangaReading: String
    let mangaCompleted: String
    let mangaOnHold: String
    let mangaDropped: String
    let mangaPlanToRead: String
    let mangaTotal: String
    let mangaScores: [String: Score]
}

// MARK: - Reviews

struct MangaReviewModel {
    let mangaReviews: [MangaReview]
}

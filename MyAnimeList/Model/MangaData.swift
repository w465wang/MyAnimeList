//
//  MangaData.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-18.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

struct MangaData: Codable {
    let title: String
    let type: String
    let status: String
    let image_url: String
    let volumes: Int?
    let chapters: Int?
    let rank: Int?
    let score: Double?
    let scored_by: Int
    let popularity: Int
    let members: Int
    let favorites: Int
    let synopsis: String?
}

// MARK: - Characters

struct MangaCharacterData: Codable {
    let characters: [MangaCharacter]
}

struct MangaCharacter: Codable {
    let mal_id: Int
    let image_url: String
    let name: String
    let role: String
}

// MARK: - Stats

struct MangaStatData: Codable {
    let reading: Int
    let completed: Int
    let on_hold: Int
    let dropped: Int
    let plan_to_read: Int
    let total: Int
    let scores: [String: Score] // From AnimeData - Stats
}

// MARK: - Reviews

struct MangaReviewData: Codable {
    let reviews: [MangaReview]
}

struct MangaReview: Codable {
    let mal_id: Int
    let helpful_count: Int
    let date: String
    let reviewer: MangaReviewer
    let content: String
}

struct MangaReviewer: Codable {
    let image_url: String
    let username: String
    let chapters_read: Int
    let scores: MangaReviewScore
}

struct MangaReviewScore: Codable {
    let overall: Int
    let story: Int
    let art: Int
    let character: Int
    let enjoyment: Int
}

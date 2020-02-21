//
//  AnimeData.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-02.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

struct AnimeData: Codable {
    let image_url: String
    let title: String
    let type: String
    let episodes: Int?
    let status: String
    let score: Double?
    let scored_by: Int?
    let rank: Int?
    let popularity: Int
    let members: Int
    let favorites: Int
    let synopsis: String?
    let premiered: String?
    let related: [String: [Related]]
}

struct Related: Codable {
    let mal_id: Int
    let type: String
    let name: String
}

// MARK: - Characters and Staff

struct AnimeCharacterData: Codable {
    let characters: [AnimeCharacter]
}

struct AnimeCharacter: Codable {
    let mal_id: Int
    let image_url: String
    let name: String
    let role: String
    let voice_actors: [VoiceActor]
}

struct VoiceActor: Codable {
    let mal_id: Int
    let name: String
    let image_url: String
    let language: String
}

// MARK: - Stats

struct AnimeStatData: Codable {
    let watching: Int
    let completed: Int
    let on_hold: Int
    let dropped: Int
    let plan_to_watch: Int
    let total: Int
    let scores: [String: Score]
}

struct Score: Codable {
    let votes: Int
    let percentage: Double
}

// MARK: - User Updates

struct AnimeUserData: Codable {
    let users: [AnimeUser]
}

struct AnimeUser: Codable {
    let username: String
    let image_url: String
    let score: Int?
    let status: String
    let episodes_seen: Int?
    let episodes_total: Int?
    let date: String
}

// MARK: - Reviews

struct AnimeReviewData: Codable {
    let reviews: [AnimeReview]
}

struct AnimeReview: Codable {
    let mal_id: Int
    let helpful_count: Int
    let date: String
    let reviewer: AnimeReviewer
    let content: String
}

struct AnimeReviewer: Codable {
    let image_url: String
    let username: String
    let episodes_seen: Int
    let scores: AnimeReviewScore
}

struct AnimeReviewScore: Codable {
    let overall: Int
    let story: Int
    let animation: Int
    let sound: Int
    let character: Int
    let enjoyment: Int
}

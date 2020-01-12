//
//  SearchData.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-03.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

struct SearchData: Codable {
    let results: [AnimeResult]
}

struct AnimeResult: Codable {
    let mal_id: Int
    let image_url: String
    let title: String
    let airing: Bool
    let type: String
    let episodes: Int
    let score: Double
    let start_date: String?
    let end_date: String?
    let members: Int
}

struct MangaResult: Codable {
    let mal_id: Int
    let image_url: String
    let title: String
    let publishing: Bool
    let type: String
    let chapters: Int
    let score: Double
    let start_date: String?
    let end_date: String?
    let members: Int
}

struct CharacterResult: Codable {
    let mal_id: Int
    let image_url: String
    let name: String
    let alternative_names: [String]
    let anime: [Blurb]
    let mange: [Blurb]
}

struct Blurb: Codable {
    let mal_id: Int
    let type: String
    let name: String
}

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

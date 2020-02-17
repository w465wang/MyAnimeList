//
//  TopData.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-02-16.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

struct TopData: Codable {
    let top: [TopAnimeManga]
}

struct TopAnimeManga: Codable {
    let mal_id: Int
    let rank: Int
    let title: String
    let url: String
    let image_url: String
    let type: String
    let start_date: String?
    let end_date: String?
    let members: Int
    let score: Double
}

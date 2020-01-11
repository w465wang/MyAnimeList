//
//  PictureData.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-11.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

struct PictureData: Codable {
    let pictures: [Picture]
}

struct Picture: Codable {
    let large: String
    let small: String
}

//
//  CharacterData.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-09.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

struct CharacterData: Codable {
    let name: String
    let name_kanji: String
    let nicknames: [String]
    let about: String
    let member_favorites: Int
    let image_url: String
    let animeography: [Ography]
    let mangaography: [Ography]
    let voice_actors: [VoiceActor] // From AnimeData - Characters and Staff
}

struct Ography: Codable {
    let mal_id: Int
    let name: String
    let image_url: String
    let role: String
}

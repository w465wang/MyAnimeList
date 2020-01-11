//
//  CharacterModel.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-09.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

struct CharacterModel {
    let characterName: String
    let characterKanji: String
    let characterNicknames: [String]
    let characterAbout: String
    let characterFavorites: String
    let characterImageURL: String
    let characterAnimeography: [Ography]
    let characterMangaography: [Ography]
    let characterVoiceActors: [VoiceActor]
}

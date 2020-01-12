//
//  PersonModel.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-11.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

struct PersonModel {
    let personImageURL: String
    let personName: String
    let personGivenName: String
    let personFamilyName: String
    let personAlternateNames: [String]
    let personMemberFavorites: Int
    let personAbout: String
    let personVoice: [VoiceActingRole]
    let personAnime: [AnimeStaffPosition]
    let personManga: [PublishedManga]
}

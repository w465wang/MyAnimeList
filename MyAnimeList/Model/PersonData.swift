//
//  PersonData.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-11.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

struct PersonData: Codable {
    let image_url: String
    let name: String
    let given_name: String?
    let family_name: String?
    let alternate_names: [String]
    let member_favorites: Int
    let about: String?
    let voice_acting_roles: [VoiceActingRole]
    let anime_staff_positions: [AnimeStaffPosition]
    let published_manga: [PublishedManga]
}

struct VoiceActingRole: Codable {
    let role: String
    let anime: RoleBlurb
    let character: RoleBlurb
}

struct AnimeStaffPosition: Codable {
    let position: String
    let anime: RoleBlurb
}

struct PublishedManga: Codable {
    let position: String
    let manga: RoleBlurb
}

struct RoleBlurb: Codable {
    let mal_id: Int
    let image_url: String
    let name: String
}

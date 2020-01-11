//
//  Constants.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-03.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

struct K {
    struct Segues {
        static let search = "homeToSearch"
        static let selection = "searchToAnime"
        static let character = "animeToCharacters"
        static let stat = "animeToStats"
        static let review = "animeToReviews"
    }
    
    struct CellIdentifier {
        static let search = "searchCell"
        static let character = "characterCell"
        static let review = "reviewCell"
    }
    
    struct AnimeRequests {
        static let null = ""
        static let charactersStaff = "characters_staff"
        static let episodes = "episodes"
        static let news = "news"
        static let pictures = "pictures"
        static let videos = "videos"
        static let stats = "stats"
        static let forum = "forum"
        static let moreinfo = "moreinfo"
        static let reviews = "reviews"
        static let recommendations = "recommendations"
        static let userupdates = "userupdates"
    }
    
    struct SearchType {
        static let anime = "anime"
        static let manga = "manga"
        static let person = "person"
        static let character = "character"
    }
    
    struct LoadingMessage {
        static let search = "Loading Results..."
        static let character = "Loading Characters..."
        static let review = "Loading Reviews..."
    }
}

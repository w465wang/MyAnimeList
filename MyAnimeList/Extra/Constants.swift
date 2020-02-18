//
//  Constants.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-03.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation
import UIImageColors

struct K {
    struct Segues {
        static let animeSearch = "animeHomeToSearch"
        static let animeTop = "animeHomeToTop"
        static let animePopular = "animeHomeToPopular"
        static let mangaSearch = "mangaHomeToSearch"
        static let mangaTop = "mangaHomeToTop"
        static let mangaPopular = "mangaHomeToPopular"
        static let topAnime = "topToAnime"
        static let topManga = "topToManga"
        static let animeSelection = "searchToAnime"
        static let mangaSelection = "searchToManga"
        static let animePicture = "animeToPictures"
        static let animeMangaCharacterList = "animeToCharacters"
        static let animeMangaStat = "animeToStats"
        static let animeMangaReview = "animeToReviews"
        static let animeMangaRelated = "animeToRelated"
        static let relatedAnime = "relatedToAnime"
        static let relatedManga = "relatedToManga"
        static let characterListCharacter = "characterListToCharacter"
        static let characterListPerson = "characterListToPerson"
        static let characterPicture = "characterToPictures"
        static let characterAnime = "characterToAnime"
        static let characterManga = "characterToManga"
        static let characterPerson = "characterToPerson"
        static let personPicture = "personToPictures"
        static let personStaff = "personToStaff"
        static let staffAnime = "staffToAnime"
        static let staffManga = "staffToManga"
        static let staffCharacter = "staffToCharacter"
    }
    
    struct CellIdentifier {
        static let search = "searchListCell"
        static let top = "topListCell"
        static let animeImage = "animeImageCell"
        static let animeSynopsis = "animeSynopsisCell"
        static let animeInfo = "animeInfoCell"
        static let animeCharacterStaff = "animeCharacterStaffCell"
        static let animeStats = "animeStatsCell"
        static let animeReviews = "animeReviewsCell"
        static let animeRelated = "animeRelatedCell"
        static let character = "characterCell"
        static let stat = "statCell"
        static let user = "userCell"
        static let review = "reviewCell"
        static let related = "relatedCell"
        static let picture = "pictureCell"
        static let characterImage = "characterImageCell"
        static let characterAbout = "characterAboutCell"
        static let characterAnime = "characterAnimeCell"
        static let characterManga = "characterMangaCell"
        static let characterActor = "characterActorCell"
        static let characterCollection = "characterCollectionCell"
        static let personImage = "personImageCell"
        static let personAbout = "personAboutCell"
        static let personStaff = "personStaffCell"
        static let personVoice = "personVoiceCell"
        static let personAnime = "personAnimeCell"
        static let personManga = "personMangaCell"
        static let personTable = "personTableCell"
        static let personList = "personListCell"
    }
    
    struct Requests {
        static let null = ""
        static let characters = "characters"
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
        static let popularity = "bypopularity"
    }
    
    struct SearchType {
        static let anime = "anime"
        static let manga = "manga"
        static let person = "person"
        static let character = "character"
    }
    
    struct VCTitle {
        static let animeHome = "Anime Home"
        static let mangaHome = "Manga Home"
    }
    
    static let defaultColors = UIImageColors.init(background: .white, primary: .white, secondary: .white, detail: .white)
}

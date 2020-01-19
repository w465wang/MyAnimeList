//
//  PictureViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-11.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class PictureViewController: UICollectionViewController {
    
    var animeManager = AnimeManager()
    var mangaManager = MangaManager()
    var characterManager = CharacterManager()
    var personManager = PersonManager()
    
    var type = ""
    var id = ""
    var pictures: [Picture]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if type == K.SearchType.anime {
            animeManager.delegate = self
            animeManager.fetchAnime(id, K.Requests.pictures)
        } else if type == K.SearchType.manga {
            mangaManager.delegate = self
            mangaManager.fetchManga(id, K.Requests.pictures)
        } else if type == K.SearchType.character {
            characterManager.delegate = self
            characterManager.fetchCharacter(id, K.Requests.pictures)
        } else if type == K.SearchType.person {
            personManager.delegate = self
            personManager.fetchPerson(id, K.Requests.pictures)
        }
        
        self.showSpinner(onView: self.view)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures?.count ?? 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CellIdentifier.picture, for: indexPath) as! PictureCell

        if pictures != nil {
            self.removeSpinner()
            cell.picture.kf.setImage(with: URL(string: pictures![indexPath.row].large))
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PictureViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width

        return CGSize(width: collectionViewSize / 2, height: collectionViewSize * 350 / 450)
    }
}

// MARK: - AnimeManagerDelegate

extension PictureViewController: AnimeManagerDelegate {
    
    func didUpdateAnime(_ animeManager: AnimeManager, _ anime: AnimeModel) {
        print("Not looking for anime.")
    }
    
    func didUpdateAnimeCharacterStaff(_ animeManager: AnimeManager, _ anime: AnimeCharacterModel) {
        print("Not looking for characters and staff.")
    }
    
    func didUpdateAnimeStat(_ animeManager: AnimeManager, _ anime: AnimeStatModel) {
        print("Not looking for stats.")
    }
    
    func didUpdateAnimeUser(_ animeManager: AnimeManager, _ anime: AnimeUserModel) {
        print("Not looking for user updates.")
    }
    
    func didUpdateAnimeReview(_ animeManager: AnimeManager, _ anime: AnimeReviewModel) {
        print("Not looking for reviews.")
    }
    
    func didUpdateAnimePicture(_ animeManager: AnimeManager, _ anime: PictureModel) {
        pictures = anime.pictures
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

// MARK: - MangaManagerDelegate

extension PictureViewController: MangaManagerDelegate {
    
    func didUpdateManga(_ mangaManager: MangaManager, _ manga: MangaModel) {
        print("Not looking for manga.")
    }
    
    func didUpdateMangaCharacter(_ mangaManager: MangaManager, _ manga: MangaCharacterModel) {
        print("Not looking for character.")
    }
    
    func didUpdateMangaReview(_ mangaManager: MangaManager, _ manga: MangaReviewModel) {
        print("Not looking for reviews.")
    }
    
    func didUpdateMangaPicture(_ mangaManager: MangaManager, _ manga: PictureModel) {
        pictures = manga.pictures
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - CharacterManagerDelegate

extension PictureViewController: CharacterManagerDelegate {
    
    func didUpdateCharacter(_ characterManager: CharacterManager, _ character: CharacterModel) {
        print("Not looking for character.")
    }
    
    func didUpdateCharacterPicture(_ characterManager: CharacterManager, _ character: PictureModel) {
        pictures = character.pictures
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - PersonManagerDelegate

extension PictureViewController: PersonManagerDelegate {
    
    func didUpdatePerson(_ personManager: PersonManager, _ person: PersonModel) {
        print("Not looking for person.")
    }
    
    func didUpdatePersonPicture(_ personManager: PersonManager, _ person: PictureModel) {
        pictures = person.pictures
        
        if pictures!.count == 0 {
            self.removeSpinner()
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

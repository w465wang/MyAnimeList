//
//  PersonViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-12.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class PersonViewController: UITableViewController {
    
    var personManager = PersonManager()
    var personID = ""
    var animeID = ""
    var mangaID = ""
    var personInfo = PersonModel(personImageURL: "", personName: "", personKanji: "", personAlternateNames: [], personFavorites: "", personAbout: "", personVoice: [], personAnime: [], personManga: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personManager.delegate = self
        personManager.fetchPerson(personID, K.Requests.null)
        self.showSpinner(onView: self.view)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if personInfo.personName != "" {
            self.removeSpinner()
            if indexPath.row == 0 {
                let cell0: ImageCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.personImage, for: indexPath) as! ImageCell
                
                cell0.picture.kf.setImage(with: URL(string: personInfo.personImageURL), for: .normal)
                cell0.picture.imageView?.contentMode = .scaleAspectFit
                
                cell0.name.text = personInfo.personName
                cell0.kanji.text = personInfo.personKanji
                cell0.favorite.text = "Member Favourites: \(personInfo.personFavorites)"
                
                return cell0
            } else if indexPath.row == 1 {
                let cell1: AboutCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.personAbout, for: indexPath) as! AboutCell
                
                var alternate = "Alternate names:"
                if personInfo.personAlternateNames.count > 0 {
                    for name in personInfo.personAlternateNames {
                        alternate.append(" \(name),")
                    }
                    
                    alternate.remove(at: alternate.index(before: alternate.endIndex))
                    alternate.append("\n")
                } else {
                    alternate = ""
                }
                
                cell1.title.text = "About"
                cell1.about.text = "\(alternate)\(personInfo.personAbout.replacingOccurrences(of: "\\n", with: ""))"
                
                return cell1
            } else if indexPath.row == 2 {
                let cell2: ButtonCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.personStaff, for: indexPath) as! ButtonCell
                
                cell2.buttonName.text = "Roles & Staff Positions"
                
                return cell2
            }
        }
        
        return UITableViewCell.init()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let cell: AboutCell = tableView.cellForRow(at: indexPath) as! AboutCell

            if cell.about.numberOfLines == 8 {
                cell.about.numberOfLines = 0
            } else {
                cell.about.numberOfLines = 8
            }
            
            self.tableView.reloadData()
        } else if indexPath.row == 2 {
            performSegue(withIdentifier: K.Segues.personStaff, sender: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func personImagePressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.personPicture, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.personPicture {
            let destinationVC = segue.destination as! PictureViewController
            destinationVC.type = "person"
            destinationVC.id = personID
        } else if segue.identifier == K.Segues.personStaff {
            let destinationVC = segue.destination as! CollectionTableViewController
            destinationVC.voice = personInfo.personVoice
            destinationVC.anime = personInfo.personAnime
            destinationVC.manga = personInfo.personManga
        }
    }
}

// MARK: - PersonManagerDelegate

extension PersonViewController: PersonManagerDelegate {
    
    func didUpdatePerson(_ personManager: PersonManager, _ person: PersonModel) {
        personInfo = PersonModel(personImageURL: person.personImageURL, personName: person.personName, personKanji: person.personKanji, personAlternateNames: person.personAlternateNames, personFavorites: person.personFavorites, personAbout: person.personAbout, personVoice: person.personVoice, personAnime: person.personAnime, personManga: person.personManga)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUpdatePersonPicture(_ personManager: PersonManager, _ person: PictureModel) {
        print("Not looking for pictures.")
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

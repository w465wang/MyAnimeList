//
//  CharacterViewController.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-04.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

class AnimeCharacterStaffViewController: UITableViewController {
    
    @IBOutlet var characterList: UITableView!
    
    var mainCharacters: [String]?
    var supportingCharacters: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else {
            return 5
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Main Characters"
        } else {
            return "Supporting Characters"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.characterCellIdentifier, for: indexPath) as UITableViewCell
        
        return cell
    }
}

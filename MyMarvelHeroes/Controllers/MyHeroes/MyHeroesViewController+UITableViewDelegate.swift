//
//  MyHeroesViewController+UITableViewDelegate.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 11/03/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation
import UIKit

extension MyHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MyHeroesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultsController?.sections?[section].numberOfObjects ?? 0
        tableView.backgroundView = count == 0 ? noMyHeroesLabel : nil
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyHeroTableViewCell.identifier, for: indexPath) as! MyHeroTableViewCell
        
        if let myHero = fetchedResultsController?.object(at: indexPath) {
            cell.prepareCell(with: myHero)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteMyHero(at: indexPath)
        default: () // Unsupported
        }
    }
}

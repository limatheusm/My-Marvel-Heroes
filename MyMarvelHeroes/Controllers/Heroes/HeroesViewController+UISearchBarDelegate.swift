//
//  HeroesViewController+UISearchBarDelegate.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 25/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation
import UIKit

extension HeroesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let name = searchBar.text {
            searchHero(with: name)
            searchActivated = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        loadHeroes(reset: searchActivated, withIndicator: searchActivated)
        searchActivated = false
    }
}

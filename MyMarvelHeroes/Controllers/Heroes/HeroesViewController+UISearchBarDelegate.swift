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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.5) {
            self.darkView.alpha = 1.0
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.5) {
            self.darkView.alpha = 0
        }
    }
    
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

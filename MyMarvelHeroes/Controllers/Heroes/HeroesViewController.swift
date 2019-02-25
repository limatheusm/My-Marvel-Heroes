//
//  HeroesViewController.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 18/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class HeroesViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var heroes: [Hero] = []
    var currentPage = 0
    var total = 0
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeroes()
    }
    
    // MARK: - setUp functions
    
    fileprivate func setUpHeroes() {
        setLoading(true)
        MarvelAPIManager.sharedInstance.getHeroes { (result) in
            switch result {
            case .failure(let errorMessage):
                self.showError(errorMessage)
            case .success(let heroesContainer):
                guard let heroes = heroesContainer.results, let total = heroesContainer.total else {
                    self.showError("Requested failed")
                    return
                }
                
                self.total = total
                self.heroes += heroes
                print("\(self.total) heróis - \(heroesContainer.count!) inseridos")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.setLoading(false)
                }
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Helpers

extension HeroesViewController {
    func showError(_ error: String) {
        print(error)
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

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
    var loadingHeroes = false
    var firstLoading = true
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeroes()
    }
    
    // MARK: - load functions
    
    func loadHeroes() {
        setLoading(true)

        MarvelAPIManager.sharedInstance.getHeroes(nameStartsWith: nil, page: currentPage) { (result) in
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
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.setLoading(false)
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
        loadingHeroes = loading
        if loading && firstLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            firstLoading = false
        }
    }
    
    func scrollToTop() {
        self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

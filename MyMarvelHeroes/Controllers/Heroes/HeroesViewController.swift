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
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var heroNameSearch: String? = {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            return searchText
        }
        return nil
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeroes(withIndicator: true)
        setUpSearchController()
        setHandleTouchInCollectionView()
    }
    
    // MARK: - Set Up Functions
    
    fileprivate func setHandleTouchInCollectionView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCollectionView(recognizer:)))
        tap.numberOfTapsRequired = 1
        self.collectionView.addGestureRecognizer(tap)
    }
    
    fileprivate func setUpSearchController() {
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false

        /* Configuring search bar */
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
    }
    
    // MARK: - load functions
    
    func loadHeroes(reset: Bool = false, withIndicator: Bool = false) {
        setLoading(true, withIndicator: withIndicator)
        let page = reset ? 0 : currentPage
        
        MarvelAPIManager.sharedInstance.getHeroes(nameStartsWith: heroNameSearch, page: page) { (result) in
            switch result {
            case .failure(let errorMessage):
                self.displayError(errorMessage)
            case .success(let heroesContainer):
                guard let heroes = heroesContainer.results, let total = heroesContainer.total else {
                    self.displayError("Requested failed")
                    return
                }
                
                if reset {
                    self.reset(total: total, heroes: heroes)
                } else {
                    self.total = total
                    self.heroes += heroes
                }
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.setLoading(false, withIndicator: withIndicator)
            }
        }
    }
    
    func searchHero(with name: String) {
        if loadingHeroes { return }
        setLoading(true, withIndicator: true)
        
        MarvelAPIManager.sharedInstance.getHeroes(nameStartsWith: name) { (result) in
            switch result {
            case .failure(let errorMessage):
                self.displayError(errorMessage)
            case .success(let heroesContainer):
                guard let heroes = heroesContainer.results, let total = heroesContainer.total else {
                    self.displayError("Requested failed")
                    return
                }
                
                self.reset(total: total, heroes: heroes)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.setLoading(false, withIndicator: true)
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
    func reset(total: Int, heroes: [Hero], currentPage: Int = 0) {
        scrollToTop(animated: false)
        self.total = total
        self.currentPage = currentPage
        self.heroes = heroes
    }
    
    func setLoading(_ loading: Bool, withIndicator: Bool) {
        loadingHeroes = loading
        if !withIndicator { return }
        
        /* From here with indicator */
        self.collectionView.isHidden = loading
        if loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func scrollToTop(animated: Bool = true) {
        DispatchQueue.main.async {
            self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
        }
    }
}

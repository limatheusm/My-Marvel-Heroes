//
//  HeroesViewController.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 18/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit
import CoreData

class HeroesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var heroes: [Hero] = []
    var currentPage = 0
    var total = 0
    var loadingHeroes = false
    var searchActivated = false
    let searchController = UISearchController(searchResultsController: nil)
    lazy var noResultsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.text = "No results"
        return label
    }()
    
    var heroNameSearch: String? {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            return searchText
        }
        return nil
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeroes(withIndicator: true)
        setUpSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    // MARK: - Set Up Functions
    
    fileprivate func setUpSearchController() {
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false

        /* Configuring search bar */
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.delegate = self
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = UIColor(named: "secondary")

        navigationItem.searchController = searchController
    }
    
    // MARK: - Network functions
    
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
    
    // MARK: - Core Data Functions
    
    func getMyHero(with id: Int, completion: @escaping (_ myHero: MyHero?) -> Void) {
        let myHeroFetchRequest: NSFetchRequest<MyHero> = MyHero.fetchRequest()
        myHeroFetchRequest.predicate = NSPredicate(format: "id == %d", Int32(id))
        myHeroFetchRequest.fetchLimit = 1
        do {
            let result = try CoreDataStack.sharedInstance.viewContext.fetch(myHeroFetchRequest)
            completion(result.first)
        } catch {
            print("\(#function) Failed")
            completion(nil)
        }
    }
    
    func save(hero: Hero, heroImage: UIImageView?, completion: @escaping (_ myHero: MyHero?, _ error: Error?) -> Void) {
        CoreDataStack.sharedInstance.performViewTask { viewContext in
            let myHero = MyHero(context: viewContext)
            
            myHero.id = Int32(hero.id!)
            myHero.about = hero.description
            myHero.name = hero.name
            myHero.image = heroImage?.image?.pngData()
            myHero.comicsCount = Int32(hero.comics?.available ?? 0)
            myHero.seriesCount = Int32(hero.series?.available ?? 0)
            myHero.storiesCount = Int32(hero.stories?.available ?? 0)
            do {
                try viewContext.save()
                completion(myHero, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    
    func delete(myHero: MyHero, completion: @escaping (_ error: Error?) -> Void) {
        CoreDataStack.sharedInstance.performViewTask { (viewContext) in
            viewContext.delete(myHero)
            do {
                try viewContext.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    // MARK: - Navigation

    func navToHeroDetails(with hero: Hero, heroImage: UIImage?) {
        let controller = HeroDetailsViewController.instanceFromStoryboard()
        controller.heroImage = heroImage
        controller.setHero(with: hero)
        navigationController?.pushViewController(controller, animated: true)
    }

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
        if Thread.isMainThread {
            self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
        } else {
            DispatchQueue.main.async {
                self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
            }
        }
    }
}

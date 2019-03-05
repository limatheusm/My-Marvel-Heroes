//
//  HeroArtifactsViewController.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 01/03/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class HeroArtifactsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var artifacts: [Artifact] = []
    var heroID: Int?
    var artifactType: ArtifactType?
    var currentPage = 0
    var total = 0
    var loadingArtifacts = false
    lazy var noResultsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.text = "No results"
        return label
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = artifactType?.path.capitalized
        loadArtifacts()
    }
    
    // MARK: - Class func
    
    class func instanceFromStoryboard() -> HeroArtifactsViewController {
        let storyboard = UIStoryboard(name: "HeroArtifacts", bundle: nil)
        return storyboard.instantiateInitialViewController() as! HeroArtifactsViewController
    }
    
    // MARK: - Load functions
    
    func loadArtifacts(withIndicator: Bool = true) {
        guard let heroID = heroID else { return }
        guard let artifactType = artifactType else { return }
        
        setLoading(true, withIndicator: withIndicator)
        
        MarvelAPIManager.sharedInstance.getHeroArtifacts(type: artifactType, heroID: heroID, page: currentPage) { (result) in
            switch result {
            case .failure(let errorMessage):
                self.displayError(errorMessage)
            case .success(let artifactsContainer):
                guard let artifacts = artifactsContainer.results, let total = artifactsContainer.total else {
                    self.displayError("Requested failed")
                    return
                }
                
                self.total = total
                self.artifacts += artifacts
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.setLoading(false, withIndicator: withIndicator)
            }
        }
    }
    
}

// MARK: - Helpers

extension HeroArtifactsViewController {
    func setLoading(_ loading: Bool, withIndicator: Bool) {
        loadingArtifacts = loading
        if !withIndicator { return }
        
        /* From here with indicator */
        self.collectionView.isHidden = loading
        if loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

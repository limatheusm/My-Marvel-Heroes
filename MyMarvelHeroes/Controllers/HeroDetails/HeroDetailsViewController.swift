//
//  HeroDetailsViewController.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 28/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class HeroDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var comicsButton: UIButton!
    @IBOutlet weak var comicsCountLabel: UILabel!
    @IBOutlet weak var seriesCountLabel: UILabel!
    @IBOutlet weak var storiesCountLabel: UILabel!
    
    // MARK: - Properties
    
    var hero: Hero?
    var heroImage: UIImage?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHero()
    }
    
    // MARK: - Class func
    
    class func instanceFromStoryboard() -> HeroDetailsViewController {
        let storyboard = UIStoryboard(name: "HeroDetails", bundle: nil)
        return storyboard.instantiateInitialViewController() as! HeroDetailsViewController
    }
    
    // MARK: - SetUp Functions
    
    fileprivate func setUpHero() {
        title = hero?.name
        heroImageView.image = heroImage
        if let description = hero?.description, !description.isEmpty {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = "Description not available"
        }
        
        comicsCountLabel.text = "\(hero?.comics?.available ?? 0)"
        seriesCountLabel.text = "\(hero?.series?.available ?? 0)"
        storiesCountLabel.text = "\(hero?.stories?.available ?? 0)"
        
        /* Comics button */
        guard let comics = hero?.comics else { return }
        comicsButton.isHidden = comics.available ?? 0 <= 0
    }
}

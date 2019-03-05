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
    @IBOutlet weak var comicsButton: Button!
    @IBOutlet weak var seriesButton: Button!
    @IBOutlet weak var storiesButton: Button!
    
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
        
        /* Comics button */
        guard let comics = hero?.comics else { return }
        comicsButton.isEnabled = comics.available ?? 0 > 0
        comicsButton.titleText = "\(comics.available ?? 0) COMICS"

        /* Series button */
        guard let series = hero?.series else { return }
        seriesButton.isEnabled = series.available ?? 0 > 0
        seriesButton.titleText = "\(series.available ?? 0) SERIES"

        /* Stories button */
        guard let stories = hero?.stories else { return }
        storiesButton.isEnabled = stories.available ?? 0 > 0
        storiesButton.titleText = "\(stories.available ?? 0) STORIES"
        
    }
    
    // MARK: - Actions
    
    @IBAction func showComics(_ sender: UIButton) {
        let controller = HeroArtifactsViewController.instanceFromStoryboard()
        controller.heroID = hero?.id
        controller.artifactType = ArtifactType.comic
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func showSeries(_ sender: UIButton) {
        let controller = HeroArtifactsViewController.instanceFromStoryboard()
        controller.heroID = hero?.id
        controller.artifactType = ArtifactType.serie
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func showStories(_ sender: UIButton) {
        let controller = HeroArtifactsViewController.instanceFromStoryboard()
        controller.heroID = hero?.id
        controller.artifactType = ArtifactType.storie
        navigationController?.pushViewController(controller, animated: true)
    }
}

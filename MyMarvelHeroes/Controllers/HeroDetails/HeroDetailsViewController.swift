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
    
    var heroImage: UIImage?
    var heroID: Int?
    var heroName: String?
    var heroDescription: String?
    var heroComicsCount: Int?
    var heroSeriesCount: Int?
    var heroStoriesCount: Int?
    
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
    
    func setHero(with hero: Hero) {
        heroID = hero.id
        heroName = hero.name
        heroDescription = hero.description
        heroComicsCount = hero.comics?.available
        heroSeriesCount = hero.series?.available
        heroStoriesCount = hero.stories?.available
    }
    
    func setHero(with myHero: MyHero) {
        if let imageData = myHero.image {
            heroImage = UIImage(data: imageData)
        }
        heroID = Int(myHero.id)
        heroName = myHero.name
        heroDescription = myHero.about
        heroComicsCount = Int(myHero.comicsCount)
        heroSeriesCount = Int(myHero.seriesCount)
        heroStoriesCount = Int(myHero.storiesCount)
    }
    
    fileprivate func setUpHero() {
        title = heroName
        heroImageView.image = heroImage
        if let description = heroDescription, !description.isEmpty {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = "Description not available"
        }
        
        /* Comics button */
        comicsButton.isEnabled = heroComicsCount ?? 0 > 0
        comicsButton.titleText = "\(heroComicsCount ?? 0) COMICS"

        /* Series button */
        seriesButton.isEnabled = heroSeriesCount ?? 0 > 0
        seriesButton.titleText = "\(heroSeriesCount ?? 0) SERIES"

        /* Stories button */
        storiesButton.isEnabled = heroStoriesCount ?? 0 > 0
        storiesButton.titleText = "\(heroStoriesCount ?? 0) STORIES"
        
    }
    
    // MARK: - Actions
    
    @IBAction func showComics(_ sender: UIButton) {
        let controller = HeroArtifactsViewController.instanceFromStoryboard()
        controller.heroID = heroID
        controller.artifactType = ArtifactType.comic
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func showSeries(_ sender: UIButton) {
        let controller = HeroArtifactsViewController.instanceFromStoryboard()
        controller.heroID = heroID
        controller.artifactType = ArtifactType.serie
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func showStories(_ sender: UIButton) {
        let controller = HeroArtifactsViewController.instanceFromStoryboard()
        controller.heroID = heroID
        controller.artifactType = ArtifactType.storie
        navigationController?.pushViewController(controller, animated: true)
    }
}

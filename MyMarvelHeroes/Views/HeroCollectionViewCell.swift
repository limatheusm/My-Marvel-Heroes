//
//  HeroCollectionViewCell.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 23/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

protocol HeroCellDelegate: class {
    func didTapFavorite(_ heroViewCell: HeroCollectionViewCell, hero: Hero?, myHero: MyHero?)
}

class HeroCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var favButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: HeroCellDelegate?
    static let identifier = "HeroCollectionViewCellID"
    var hero: Hero?
    var myHero: MyHero? {
        didSet {
            favButton.setImage(UIImage(named: myHero != nil ? "liked" : "like"), for: .normal)
        }
    }
    
    /* change opacity when user touches cell */
    override var isHighlighted: Bool {
        didSet {
            self.layer.opacity = isHighlighted ? 0.5 : 1
        }
    }
    
    override func prepareForReuse() {
        thumbImageView.image = nil
        favButton.setImage(nil, for: .normal)
        hero = nil
        super.prepareForReuse()
    }
    
    func prepareCell(with hero: Hero, myHero: MyHero?) {
        self.hero = hero
        self.myHero = myHero
        nameLabel.text = hero.name
        thumbImageView.image = nil
        
        if let imageData = myHero?.image {
            thumbImageView.image = UIImage(data: imageData)
        } else {
            /* Download the image or recover from the cache */
            activityIndicator.startAnimating()
            MarvelAPIManager.sharedInstance.downloadThumbnail(from: hero.thumbnail?.url) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure:
                        self.thumbImageView.image = UIImage(named: "imageNotFound")
                    case .success(let uiImage):
                        self.thumbImageView.image = uiImage
                    }
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func favAction(_ sender: Any) {
        delegate?.didTapFavorite(self, hero: hero, myHero: myHero)
    }
}

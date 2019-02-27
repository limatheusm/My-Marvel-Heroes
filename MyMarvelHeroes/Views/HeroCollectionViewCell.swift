//
//  HeroCollectionViewCell.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 23/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static let identifier = "HeroCollectionViewCellID"
    
    func prepareCell(with hero: Hero) {
        nameLabel.text = hero.name
        thumbImageView.image = nil
        activityIndicator.startAnimating()
        /* Download the image or recover from the cache */
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
    
    override func prepareForReuse() {
        thumbImageView.image = nil
        super.prepareForReuse()
    }
}

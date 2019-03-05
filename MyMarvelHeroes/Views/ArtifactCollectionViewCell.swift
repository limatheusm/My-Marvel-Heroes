//
//  ArtifactCollectionViewCell.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 01/03/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation
import UIKit

class ArtifactCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    
    static let identifier = "ArtifactCollectionViewCellID"
    
    override func prepareForReuse() {
        imageView.image = nil
        super.prepareForReuse()
    }
    
    func prepareCell(with artifact: Artifact) {
        titleLabel.text = artifact.title
        imageView.image = nil
        
        activityIndicator.startAnimating()
        /* Download the image or recover from the cache */
        MarvelAPIManager.sharedInstance.downloadThumbnail(from: artifact.thumbnail?.portraitUrl) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    self.imageView.image = UIImage(named: "imageNotFound")
                case .success(let uiImage):
                    self.imageView.image = uiImage
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

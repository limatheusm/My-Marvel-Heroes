//
//  ArtifactDetailsViewController.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 05/03/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class ArtifactDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var blurImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    var artifact: Artifact?
    var artifactImage: UIImage?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpArtifact()
    }
    
    // MARK: - Class func
    
    class func instanceFromStoryboard() -> ArtifactDetailsViewController {
        let storyboard = UIStoryboard(name: "ArtifactDetails", bundle: nil)
        return storyboard.instantiateInitialViewController() as! ArtifactDetailsViewController
    }

    // MARK: - Set Up Functions
    
    fileprivate func setUpArtifact() {
        title = artifact?.title
        
        /* Image */
        imageView.image = artifactImage
        blurImageView.image = artifactImage
        addBlur(blurImageView)
        
        /* Labels */
        publishedDateLabel.text = formatDate(from: artifact?.dates?.first?.date) ?? "No date available"
        titleLabel.text = artifact?.title ?? "No title available"
        if let description = artifact?.description, !description.isEmpty {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = "Description not available"
        }
    }

}

// MARK: - Helpers

extension ArtifactDetailsViewController {
    fileprivate func addBlur(_ imageView: UIImageView) {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        effectView.frame = view.bounds
        imageView.addSubview(effectView)
    }
    
    fileprivate func formatDate(from dateString: String?) -> String? {
        guard let dateString = dateString else { return nil }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = MarvelAPI.Constants.DateFormat
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        
        if let date = dateFormatterGet.date(from: dateString) {
            return dateFormatterPrint.string(from: date)
        } else {
            return nil
        }
    }
}

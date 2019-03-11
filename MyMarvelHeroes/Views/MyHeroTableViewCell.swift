//
//  MyHeroTableViewCell.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 11/03/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class MyHeroTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    static let identifier = "myHeroCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        heroImageView.image = nil
        nameLabel.text = nil
    }

    func prepareCell(with myHero: MyHero) {
        guard let imageData = myHero.image else { return }
        
        heroImageView.image = UIImage(data: imageData)
        nameLabel.text = myHero.name
    }
}

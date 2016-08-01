//
//  MovieCollectionViewCell.swift
//  MovieHound
//
//  Created by admin on 7/16/16.
//  Copyright © 2016 Micheal Hannan. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
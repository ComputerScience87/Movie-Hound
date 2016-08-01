//
//  SearchTableViewCell.swift
//  MovieHound
//
//  Created by admin on 7/16/16.
//  Copyright © 2016 Micheal Hannan. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var MovieTitleLabel: UILabel!
    @IBOutlet weak var YearReleasedLabel: UILabel!
    @IBOutlet weak var MovieRatingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

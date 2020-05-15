//
//  SingleYahtzeeTableViewCell.swift
//  SimpleYahtzee
//
//  Created by Taylor Waddel on 13/05/20.
//  Copyright © 2020 Taylor Waddel. All rights reserved.
//

import UIKit

class SingleYahtzeeTableViewCell: UITableViewCell {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

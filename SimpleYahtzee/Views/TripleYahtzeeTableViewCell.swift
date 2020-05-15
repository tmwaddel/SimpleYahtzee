//
//  TripleYahtzeeTableViewCell.swift
//  SimpleYahtzee
//
//  Created by Taylor Waddel on 13/05/20.
//  Copyright © 2020 Taylor Waddel. All rights reserved.
//

import UIKit

class TripleYahtzeeTableViewCell: UITableViewCell {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var buttonScore1: UIButton!
    @IBOutlet weak var buttonScore2: UIButton!
    @IBOutlet weak var buttonScore3: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

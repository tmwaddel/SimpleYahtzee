//
//  TripleGameCell.swift
//  SimpleYahtzee
//
//  Created by Taylor Waddel on 18/05/20.
//  Copyright © 2020 Taylor Waddel. All rights reserved.
//

import UIKit

class TripleGameCell: UITableViewCell {
    @IBOutlet weak var scoreLabel: UIButton!
    @IBOutlet weak var score1: UIButton!
    @IBOutlet weak var score2: UIButton!
    @IBOutlet weak var score3: UIButton!
    
    private let buttonCornerRadius: CGFloat = 6
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        scoreLabel.layer.cornerRadius = buttonCornerRadius
        score1.layer.cornerRadius = buttonCornerRadius
        score2.layer.cornerRadius = buttonCornerRadius
        score3.layer.cornerRadius = buttonCornerRadius
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // This function is needed to prevent reused cells from behaving strangely as the tableview scrolls.
        
        score1.isHidden = false
        score2.isHidden = false
        score3.isHidden = false
    }
    
    
    @IBAction func scoreLabelButton(_ sender: UIButton) {
        print("\(self.scoreLabel.currentTitle ?? ""), Label Button")
    }
    
    @IBAction func score1Button(_ sender: UIButton) {
        print("\(self.scoreLabel.currentTitle ?? ""), Button 1")
    }
    
    @IBAction func score2Button(_ sender: UIButton) {
        print("\(self.scoreLabel.currentTitle ?? ""), Button 2")
    }
    
    @IBAction func score3Button(_ sender: UIButton) {
        print("\(self.scoreLabel.currentTitle ?? ""), Button 3")
    }
}

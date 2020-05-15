//
//  SingleGameViewController.swift
//  SimpleYahtzee
//
//  Created by Taylor Waddel on 13/05/20.
//  Copyright © 2020 Taylor Waddel. All rights reserved.
//

import UIKit

class SingleGameViewController: UIViewController {
    var singleGame: SingleYahtzeeGameBrain?
    
    // Dictionary for converting UIButton tag to a string
    let scoreButtons: [Int : String] = [
        6 : K.one,
        7 : K.two,
        8 : K.three,
        9 : K.four,
        10 : K.five,
        11 : K.six,
        12 : K.k3,
        13 : K.k4,
        14 : K.fh,
        15 : K.smstr,
        16 : K.lgstr,
        17 : K.ytz,
        18 : K.chnc
    ]
    
    @IBOutlet weak var onesScore: UIButton!
    @IBOutlet weak var twosScore: UIButton!
    @IBOutlet weak var threesScore: UIButton!
    @IBOutlet weak var foursScore: UIButton!
    @IBOutlet weak var fivesScore: UIButton!
    @IBOutlet weak var sixesScore: UIButton!
    @IBOutlet weak var threeKindScore: UIButton!
    @IBOutlet weak var fourKindScore: UIButton!
    @IBOutlet weak var fullHouseScore: UIButton!
    @IBOutlet weak var smStrScore: UIButton!
    @IBOutlet weak var lgStrScore: UIButton!
    @IBOutlet weak var yahtzeeScore: UIButton!
    @IBOutlet weak var chanceScore: UIButton!
    
    @IBOutlet weak var topTotalLabel: UILabel!
    @IBOutlet weak var bottomTotalLabel: UILabel!
    @IBOutlet weak var gameTotalLabel: UILabel!
    @IBOutlet weak var topBonusLabel: UILabel!
    @IBOutlet weak var yahtzeeBonusLabel: UILabel!
    
    @IBOutlet weak var dice1: UIButton!
    @IBOutlet weak var dice2: UIButton!
    @IBOutlet weak var dice3: UIButton!
    @IBOutlet weak var dice4: UIButton!
    @IBOutlet weak var dice5: UIButton!
    
    @IBOutlet weak var rollButtonItem: UIButton!
    
    let buttonCornerRadius: CGFloat = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Give each of the pressable features a nice rounded corner
        onesScore.layer.cornerRadius = buttonCornerRadius;
        twosScore.layer.cornerRadius = buttonCornerRadius;
        threesScore.layer.cornerRadius = buttonCornerRadius;
        foursScore.layer.cornerRadius = buttonCornerRadius;
        fivesScore.layer.cornerRadius = buttonCornerRadius;
        sixesScore.layer.cornerRadius = buttonCornerRadius;
        threeKindScore.layer.cornerRadius = buttonCornerRadius;
        fourKindScore.layer.cornerRadius = buttonCornerRadius;
        fullHouseScore.layer.cornerRadius = buttonCornerRadius;
        smStrScore.layer.cornerRadius = buttonCornerRadius;
        lgStrScore.layer.cornerRadius = buttonCornerRadius;
        yahtzeeScore.layer.cornerRadius = buttonCornerRadius;
        chanceScore.layer.cornerRadius = buttonCornerRadius;
        
        dice1.layer.cornerRadius = buttonCornerRadius;
        dice2.layer.cornerRadius = buttonCornerRadius;
        dice3.layer.cornerRadius = buttonCornerRadius;
        dice4.layer.cornerRadius = buttonCornerRadius;
        dice5.layer.cornerRadius = buttonCornerRadius;
        
        rollButtonItem.layer.cornerRadius = buttonCornerRadius;
        
        // Change the back button to say "Quit" instead
        let backButton = UIBarButtonItem()
        backButton.title = "Quit"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // Initialize our single Yahtzee game brain
        singleGame = SingleYahtzeeGameBrain()
    }
    
    
    func updateDice() {
        // Sets the background color of the dice to indicate it's being held
        dice1.backgroundColor = singleGame?.heldStatusColor(n: 1)
        dice2.backgroundColor = singleGame?.heldStatusColor(n: 2)
        dice3.backgroundColor = singleGame?.heldStatusColor(n: 3)
        dice4.backgroundColor = singleGame?.heldStatusColor(n: 4)
        dice5.backgroundColor = singleGame?.heldStatusColor(n: 5)

        // Sets the dice image to match the dice value
        dice1.setImage(singleGame?.getDiceImage(n: 1), for: .normal)
        dice2.setImage(singleGame?.getDiceImage(n: 2), for: .normal)
        dice3.setImage(singleGame?.getDiceImage(n: 3), for: .normal)
        dice4.setImage(singleGame?.getDiceImage(n: 4), for: .normal)
        dice5.setImage(singleGame?.getDiceImage(n: 5), for: .normal)
    }
    
    
    func updateScores() {
        // Update each of the score buttons/labels from the ScoreColumns object
        onesScore.setTitle(singleGame?.getScore(forRow: K.one), for: .normal)
        twosScore.setTitle(singleGame?.getScore(forRow: K.two), for: .normal)
        threesScore.setTitle(singleGame?.getScore(forRow: K.three), for: .normal)
        foursScore.setTitle(singleGame?.getScore(forRow: K.four), for: .normal)
        fivesScore.setTitle(singleGame?.getScore(forRow: K.five), for: .normal)
        sixesScore.setTitle(singleGame?.getScore(forRow: K.six), for: .normal)
        threeKindScore.setTitle(singleGame?.getScore(forRow: K.k3), for: .normal)
        fourKindScore.setTitle(singleGame?.getScore(forRow: K.k4), for: .normal)
        fullHouseScore.setTitle(singleGame?.getScore(forRow: K.fh), for: .normal)
        smStrScore.setTitle(singleGame?.getScore(forRow: K.smstr), for: .normal)
        lgStrScore.setTitle(singleGame?.getScore(forRow: K.lgstr), for: .normal)
        yahtzeeScore.setTitle(singleGame?.getScore(forRow: K.ytz), for: .normal)
        chanceScore.setTitle(singleGame?.getScore(forRow: K.chnc), for: .normal)
        topTotalLabel.text = singleGame?.getScore(forRow: K.toptot)
        bottomTotalLabel.text = singleGame?.getScore(forRow: K.bottot)
        gameTotalLabel.text = singleGame?.getScore(forRow: K.gametot)
        topBonusLabel.text = singleGame?.getScore(forRow: K.topbon)
        yahtzeeBonusLabel.text = singleGame?.getScore(forRow: K.ytzbon)
    }
    
    
    func checkYahtzeeBonus() {
        if (singleGame?.yahtzeeBonus())! {
            print("Yahtzee Bonus Found")
        }
    }

    
    @IBAction func rollDice(_ sender: UIButton) {
        // Advance the turn
        singleGame?.nextTurn()
        
        // Check if the round is over and disable the roll button
        if (singleGame?.roundOver())! {
            sender.isEnabled = false
        }
        
        // handRolled() sets the rolled flag to true, indicating the turn has started
        singleGame?.handRolled()
        
        // Update the dice and scores button titles and labels
        updateDice()
        updateScores()
        checkYahtzeeBonus()
    }
    
    
    @IBAction func diceHold(_ sender: UIButton) {
        // If the turn has started, allow the user to hold the dice
        if (singleGame?.isHandRolled())! {
            singleGame?.toggleHeld(n: sender.tag)

            updateDice()
        }
    }
    
    
    @IBAction func setScore(_ sender: UIButton) {
        // If the turn has started, allow the user to set the score
        if (singleGame?.isHandRolled())! {
            // Set the score within the singleGame struct
            singleGame?.setScore(forRow: scoreButtons[sender.tag]!)
            updateScores()
            
            // Format score buttons to indicate it's been used
            sender.isEnabled = false
            sender.backgroundColor = UIColor(named: "ScoredBGColor")
            
            singleGame?.nextRound()
            
            // If the game is over, deactivate and change the roll button title
            // If the game is still in progress, enable the roll button and update the scores/dice
            if (singleGame?.gameOver())! {
                rollButtonItem.isEnabled = false
                rollButtonItem.setTitle("Game Over!", for: .disabled)
            } else {
                rollButtonItem.isEnabled = true
                
                updateDice()
                updateScores()
            }
        }
    }
}

//
//  SingleYahtzeeGameBrain.swift
//  SimpleYahtzee
//
//  Created by Taylor Waddel on 13/05/20.
//  Copyright © 2020 Taylor Waddel. All rights reserved.
//

import UIKit

struct SingleYahtzeeGameBrain {
    private var diceHand: DiceHand
    private var scoreCol: ScoreColumn
    
    private var roundNumber: Int
    private var roundsMax: Int = 14
    private var turnNumber: Int
    private var turnsMax: Int = 3
    private var rolled: Bool
    
    private var heldColor: UIColor = UIColor(named: "HoldBackgroundColor")!
    private var rollColor: UIColor = UIColor(named: "RollBackgroundColor")!
    
    // An array of images used to set the dice on the user screen
    private var diceImages: [UIImage] = [
        UIImage(imageLiteralResourceName: "EmptyDice"),
        UIImage(imageLiteralResourceName: "OneDice"),
        UIImage(imageLiteralResourceName: "TwoDice"),
        UIImage(imageLiteralResourceName: "ThreeDice"),
        UIImage(imageLiteralResourceName: "FourDice"),
        UIImage(imageLiteralResourceName: "FiveDice"),
        UIImage(imageLiteralResourceName: "SixDice")
    ]
    
    
    init() {
        // Initialize our DiceHand and ScoreColumn for use.
        diceHand = DiceHand()
        scoreCol = ScoreColumn()
        
        roundNumber = 1 // 13 total rounds
        turnNumber = 0 // 3 total turns per round
        rolled = false // First roll has not taken place flag
    }
    
    
    mutating func nextTurn() {
        // Roll button tapped, roll dice and increase the turn number
        diceHand.rollHand()
        turnNumber += 1
    }
    
    
    mutating func nextRound() {
        // When a round has ended (and a score has been selected), reset the dice hand, turn number, and rolled flag.
        // Increas the round number.
        diceHand.resetHand()
        turnNumber = 0
        roundNumber += 1
        self.rolled = false
    }
    
    
    mutating func handRolled() {
        // Enable the rolled flag to indicate the turn has started.
        self.rolled = true
    }
    
    
    func roundOver() -> Bool {
        // Check if the round has ended.
        //if turnNumber >= 3 {
        if turnNumber >= turnsMax {
            return true
        } else {
            return false
        }
    }
    
    
    func gameOver() -> Bool {
        // Check if the game has ended (13 turns)
        if roundNumber >= roundsMax {
            return true
        } else {
            return false
        }
    }
    
    
    func isHandRolled() -> Bool {
        // Check the rolled flag to see if the round has started.
        return rolled
    }
    
    
    mutating func toggleHeld(n: Int) {
        // Toggle the flag to hold or not hold the selected die.
        diceHand.toggleHeld(diceNum: n)
    }
    
    
    func heldStatusColor(n: Int) -> UIColor {
        // Return the color of a die (held vs. not)
        return diceHand.isHeld(diceNum: n) ? heldColor : rollColor
    }
    
    
    func getDiceImage(n: Int) -> UIImage {
        // Return the image for the corresponding die value
        return diceImages[self.diceHand.getDice(diceNum: n)]
    }
    
    mutating func yahtzeeBonus() -> Bool {
        // Checking to see if a yahtzee has been rolled for yahtzee bonus calculation
        //  If a yahtzee has been scored previously and a yahtzee has been rolled, return true.
        let yhtScore: Bool = scoreCol.yahtzee.getUsed()
        let yhtPoints: Int = scoreCol.yahtzee.getPoints()
        let yhtRolled: Bool = diceHand.yahtzeeCheck()
        
        if yhtScore && yhtRolled && (yhtPoints == 50) {
            // Ends the turn and increases the Yahtzee Bonus field
            // turnNumber = 3
            turnNumber = turnsMax
            scoreCol.setYahtzeeBonus()
            
            return true
        } else {
            return false
        }
    }
    
    
    mutating func setScore(forRow: String, yhtzBonus: Bool) {
        // Set the score based on the button tapped.
        switch forRow {
        case K.one:
            if !scoreCol.oneScore.getUsed() {
                _ = scoreCol.oneScore.setPoints(score: diceHand.getTopScore(n: 1))
            }
        case K.two:
            if !scoreCol.twoScore.getUsed() {
                _ = scoreCol.twoScore.setPoints(score: diceHand.getTopScore(n: 2))
            }
        case K.three:
            if !scoreCol.threeScore.getUsed() {
                _ = scoreCol.threeScore.setPoints(score: diceHand.getTopScore(n: 3))
            }
        case K.four:
            if !scoreCol.fourScore.getUsed() {
                _ = scoreCol.fourScore.setPoints(score: diceHand.getTopScore(n: 4))
            }
        case K.five:
            if !scoreCol.fiveScore.getUsed() {
                _ = scoreCol.fiveScore.setPoints(score: diceHand.getTopScore(n: 5))
            }
        case K.six:
            if !scoreCol.sixScore.getUsed() {
                _ = scoreCol.sixScore.setPoints(score: diceHand.getTopScore(n: 6))
            }
        case K.k3:
            if !scoreCol.threeKind.getUsed() {
                _ = scoreCol.threeKind.setPoints(score: diceHand.getNKind(n: 3))
            }
        case K.k4:
            if !scoreCol.fourKind.getUsed() {
                _ = scoreCol.fourKind.setPoints(score: diceHand.getNKind(n: 4))
            }
        case K.fh:
            if !scoreCol.fullHouse.getUsed() {
                _ = scoreCol.fullHouse.setPoints(score: diceHand.getFullHouse())
            }
        case K.smstr:
            if !scoreCol.smStr.getUsed() {
                if yhtzBonus {
                    _ = scoreCol.smStr.setPoints(score: 30)
                } else {
                    _ = scoreCol.smStr.setPoints(score: diceHand.getSmStr())
                }
            }
        case K.lgstr:
            if !scoreCol.lgStr.getUsed() {
                if yhtzBonus {
                    _ = scoreCol.lgStr.setPoints(score: 40)
                } else {
                    _ = scoreCol.lgStr.setPoints(score: diceHand.getLgStr())
                }
            }
        case K.ytz:
            if !scoreCol.yahtzee.getUsed() {
                _ = scoreCol.yahtzee.setPoints(score: diceHand.getYahtzee())
            }
        case K.chnc:
            if !scoreCol.chance.getUsed() {
                _ = scoreCol.chance.setPoints(score: diceHand.getChance())
            }
        default:
            return
        }
    }
    
    
    mutating func getScore(forRow: String) -> String {
        // Get the score for the button or label selected.
        switch forRow {
        case K.one:
            let name = scoreCol.oneScore.getName()
            return scoreCol.oneScore.getUsed() ? "\(name): \(scoreCol.oneScore.getPoints())" : "\(name): \(diceHand.getTopScore(n: 1))"
        case K.two:
            let name = scoreCol.twoScore.getName()
            return scoreCol.twoScore.getUsed() ? "\(name): \(scoreCol.twoScore.getPoints())" : "\(name): \(diceHand.getTopScore(n: 2))"
        case K.three:
            let name = scoreCol.threeScore.getName()
            return scoreCol.threeScore.getUsed() ? "\(name): \(scoreCol.threeScore.getPoints())" : "\(name): \(diceHand.getTopScore(n: 3))"
        case K.four:
            let name = scoreCol.fourScore.getName()
            return scoreCol.fourScore.getUsed() ? "\(name): \(scoreCol.fourScore.getPoints())" : "\(name): \(diceHand.getTopScore(n: 4))"
        case K.five:
            let name = scoreCol.fiveScore.getName()
            return scoreCol.fiveScore.getUsed() ? "\(name): \(scoreCol.fiveScore.getPoints())" : "\(name): \(diceHand.getTopScore(n: 5))"
        case K.six:
            let name = scoreCol.sixScore.getName()
            return scoreCol.sixScore.getUsed() ? "\(name): \(scoreCol.sixScore.getPoints())" : "\(name): \(diceHand.getTopScore(n: 6))"
        case K.k3:
            let name = scoreCol.threeKind.getName()
            return scoreCol.threeKind.getUsed() ? "\(name): \(scoreCol.threeKind.getPoints())" : "\(name): \(diceHand.getNKind(n: 3))"
        case K.k4:
            let name = scoreCol.fourKind.getName()
            return scoreCol.fourKind.getUsed() ? "\(name): \(scoreCol.fourKind.getPoints())" : "\(name): \(diceHand.getNKind(n: 4))"
        case K.fh:
            let name = scoreCol.fullHouse.getName()
            return scoreCol.fullHouse.getUsed() ? "\(name): \(scoreCol.fullHouse.getPoints())" : "\(name): \(diceHand.getFullHouse())"
        case K.smstr:
            let name = scoreCol.smStr.getName()
            return scoreCol.smStr.getUsed() ? "\(name): \(scoreCol.smStr.getPoints())" : "\(name): \(diceHand.getSmStr())"
        case K.lgstr:
            let name = scoreCol.lgStr.getName()
            return scoreCol.lgStr.getUsed() ? "\(name): \(scoreCol.lgStr.getPoints())" : "\(name): \(diceHand.getLgStr())"
        case K.ytz:
            let name = scoreCol.yahtzee.getName()
            return scoreCol.yahtzee.getUsed() ? "\(name): \(scoreCol.yahtzee.getPoints())" : "\(name): \(diceHand.getYahtzee())"
        case K.chnc:
            let name = scoreCol.chance.getName()
            return scoreCol.chance.getUsed() ? "\(name): \(scoreCol.chance.getPoints())" : "\(name): \(diceHand.getChance())"
        case K.toptot:
            return "\(K.toptot): \(scoreCol.getTopTot())"
        case K.bottot:
            return "\(K.bottot): \(scoreCol.getBotTot())"
        case K.gametot:
            return "\(K.gametot): \(scoreCol.getGameTotal())"
        case K.topbon:
            return "\(K.topbon): \(scoreCol.topBonus.getPoints())"
        case K.ytzbon:
            return "\(K.ytzbon): \(scoreCol.yahtzeeBonus.getPoints())"
        default:
            return ""
        }
    }
    
    mutating func getFinalScore() -> Int {
        return scoreCol.getGameTotal()
    }
}

//
//  DiceHand.swift
//  SimpleYahtzee
//
//  Created by Taylor Waddel on 14/05/20.
//  Copyright © 2020 Taylor Waddel. All rights reserved.
//

import Foundation

struct DiceHand {
    private var diceHandNumbers: [Int] = [0, 0, 0, 0, 0]
    private var diceHandHeld: [Bool] = [false, false, false, false, false]
    
    
    mutating func rollHand() {
        // Roll all the dice in the hand if they're not held
        for i in 0..<diceHandNumbers.count {
            if !diceHandHeld[i] {
                diceHandNumbers[i] = Int.random(in: 1...6)
            }
        }
    }
    
    
    func getDice(diceNum: Int) -> Int {
        // Get the current value of a selected die
        return diceHandNumbers[diceNum - 1]
    }
    
    
    func isHeld(diceNum: Int) -> Bool {
        // Check if a die is held
        return diceHandHeld[diceNum - 1]
    }
    
    
    mutating func toggleHeld(diceNum: Int) {
        // Toggle the held status
        diceHandHeld[diceNum - 1] = !diceHandHeld[diceNum - 1]
    }
    
    
    mutating func resetHand() {
        // Reset the hand to the basic setup, all 0 and none held.
        for i in 0..<diceHandHeld.count {
            diceHandHeld[i] = false
            diceHandNumbers[i] = 0
        }
    }
    
    
    func getTopScore(n: Int) -> Int {
        // Get the score values for the top section (Number * QtyFound)
        let nCount: [Int] = diceHandNumbers.filter{ $0 == n }
        return (nCount.count) * n
    }
    
    
    func getNKind(n: Int) -> Int {
        // Gets 3 or 4 of a kind, 3 or 4 dice all the same (Sum of all dice if found)
        if n != 3 && n != 4 {
            return 0
        }

        for i in 1...6 {
            let tempCount: [Int] = diceHandNumbers.filter{ $0 == i }

            if tempCount.count >= n {
                return diceHandNumbers.reduce(0, +)
            }
        }

        return 0
    }
    
    
    func getFullHouse() -> Int {
        // Checks for a full house, 1 pair and 1 triple (25 pts)
        let counts: [Int] = getDiceCounts()
        
        return (counts.contains(2) && counts.contains(3) || counts.contains(5)) ? 25 : 0
    }
    
    
    func getSmStr() -> Int {
        // Checks for small straight, (1, 2, 3, 4) || (2, 3, 4, 5) || (3, 4, 5, 6). (30 pts)
        let counts: [Int] = getDiceCounts()
        
        if (counts[0] >= 1) && (counts[1] >= 1) && (counts[2] >= 1) && (counts[3] >= 1) {
            return 30
        } else if (counts[1] >= 1) && (counts[2] >= 1) && (counts[3] >= 1) && (counts[4] >= 1) {
            return 30
        } else if (counts[2] >= 1) && (counts[3] >= 1) && (counts[4] >= 1) && (counts[5] >= 1) {
            return 30
        } else {
            return 0
        }
    }
    
    
    func getLgStr() -> Int {
        // Checks for large straight, (1, 2, 3, 4, 5) || (2, 3, 4, 5, 6) (40 pts)
        let counts: [Int] = getDiceCounts()
        
        if (counts[0] == 1) && (counts[1] == 1) && (counts[2] == 1) && (counts[3] == 1) && (counts[4] == 1) {
            return 40
        } else if (counts[1] == 1) && (counts[2] == 1) && (counts[3] == 1) && (counts[4] == 1) && (counts[5] == 1) {
            return 40
        } else {
            return 0
        }
    }
    
    
    func getYahtzee() -> Int {
        // Checks for a Yahtzee, all 5 dice the same (50 pts)
        let counts: [Int] = getDiceCounts()
        
        if counts.contains(5) {
            return 50
        } else {
            return 0
        }
    }
    
    
    func yahtzeeCheck() -> Bool {
        // Checks for a Yahtzee, all 5 dice the same (True or False for checking)
        let counts: [Int] = getDiceCounts()
        
        if counts.contains(5) {
            return true
        } else {
            return false
        }
    }
    
    
    private func getDiceCounts() -> [Int] {
        // Filters the hand into an array to enable easier checking of scores
        var counts: [Int] = [0, 0, 0, 0, 0, 0]
        
        for i in 0..<counts.count {
            counts[i] = (diceHandNumbers.filter{ $0 == (i+1) }).count
        }
        
        return counts
    }
    
    
    func getChance() -> Int {
        // Chance is just the sum of the dice, can be used any time.
        return diceHandNumbers.reduce(0, +)
    }
}

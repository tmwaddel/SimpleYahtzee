//
//  ScoreColumn.swift
//  SimpleYahtzee
//
//  Created by Taylor Waddel on 14/05/20.
//  Copyright © 2020 Taylor Waddel. All rights reserved.
//

import Foundation

struct ScoreColumn {
    // ScoreField is a struct used to hold the name, points, and set status of a score.
    struct ScoreField {
        var scoreName: String
        var scorePoints: Int
        var scoreUsed: Bool
        
        init(name: String) {
            self.scoreName = name
            self.scorePoints = 0
            self.scoreUsed = false
        }
        
        // Getters
        func getName() -> String { return self.scoreName }
        func getPoints() -> Int { return self.scorePoints }
        func getUsed() -> Bool { return self.scoreUsed }
        
        // Setters
        mutating func setPoints(score: Int) -> Bool{
            if !self.scoreUsed {
                self.scorePoints = score
                self.scoreUsed = true
                return true
            } else {
                return false
            }
        }
    }
    
    
    // 13 elements for 13 turns
    var oneScore: ScoreField = ScoreField(name: K.one)
    var twoScore: ScoreField = ScoreField(name: K.two)
    var threeScore: ScoreField = ScoreField(name: K.three)
    var fourScore: ScoreField = ScoreField(name: K.four)
    var fiveScore: ScoreField = ScoreField(name: K.five)
    var sixScore: ScoreField = ScoreField(name: K.six)
    
    var threeKind: ScoreField = ScoreField(name: K.k3)
    var fourKind: ScoreField = ScoreField(name: K.k4)
    var fullHouse: ScoreField = ScoreField(name: K.fh)
    var smStr: ScoreField = ScoreField(name: K.smstr)
    var lgStr: ScoreField = ScoreField(name: K.lgstr)
    var yahtzee: ScoreField = ScoreField(name: K.ytz)
    var chance: ScoreField = ScoreField(name: K.chnc)

    // 2 Additional bonus elements
    // TODO: - Implement the Yahtzee Bonus Logic
    var topBonus: ScoreField = ScoreField(name: K.topbon)
    var yahtzeeBonus: ScoreField = ScoreField(name: K.ytzbon)
    
    
    mutating func getTopTot() -> Int {
        // Sum the top score totals
        var topTotal: Int = 0
        
        if oneScore.getUsed() { topTotal += oneScore.getPoints() }
        if twoScore.getUsed() { topTotal += twoScore.getPoints() }
        if threeScore.getUsed() { topTotal += threeScore.getPoints() }
        if fourScore.getUsed() { topTotal += fourScore.getPoints() }
        if fiveScore.getUsed() { topTotal += fiveScore.getPoints() }
        if sixScore.getUsed() { topTotal += sixScore.getPoints() }
        
        if topTotal >= 63 { _ = topBonus.setPoints(score: 35) }
        
        return topTotal + topBonus.getPoints()
    }
    
    
    mutating func setYahtzeeBonus() {
        // Update the yahtzee bonus score when triggered.
        if yahtzee.getUsed() {
            yahtzeeBonus.scorePoints += 100
        }
    }
    
    
    func getBotTot() -> Int {
        // Sum the bottom score totals
        var botTotal: Int = 0
        
        if threeKind.getUsed() { botTotal += threeKind.getPoints() }
        if fourKind.getUsed() { botTotal += fourKind.getPoints() }
        if fullHouse.getUsed() { botTotal += fullHouse.getPoints() }
        if smStr.getUsed() { botTotal += smStr.getPoints() }
        if lgStr.getUsed() { botTotal += lgStr.getPoints() }
        if yahtzee.getUsed() { botTotal += yahtzee.getPoints() }
        if chance.getUsed() { botTotal += chance.getPoints() }
        
        return botTotal + yahtzeeBonus.getPoints()
    }
    
    
    mutating func getGameTotal() -> Int {
        // Get the full game score
        return getTopTot() + getBotTot()
    }
}

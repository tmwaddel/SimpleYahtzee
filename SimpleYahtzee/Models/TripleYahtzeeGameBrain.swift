//
//  TripleYahtzeeGameBrain.swift
//  SimpleYahtzee
//
//  Created by Taylor Waddel on 13/05/20.
//  Copyright © 2020 Taylor Waddel. All rights reserved.
//

import Foundation

struct TripleYahtzeeGameBrain {
    var turnNumber: Int
    var roundNumber: Int
    
    var maxTurns: Int = 3
    var maxRounds: Int = 20
    
    init() {
        turnNumber = 0
        roundNumber = 0
    }
}

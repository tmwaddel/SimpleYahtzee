//
//  TripleGameViewController.swift
//  SimpleYahtzee
//
//  Created by Taylor Waddel on 17/05/20.
//  Copyright © 2020 Taylor Waddel. All rights reserved.
//

import UIKit

class TripleGameViewController: UIViewController {
    @IBOutlet weak var scoresTableView: UITableView!
    
    @IBOutlet weak var dice1Button: UIButton!
    @IBOutlet weak var dice2Button: UIButton!
    @IBOutlet weak var dice3Button: UIButton!
    @IBOutlet weak var dice4Button: UIButton!
    @IBOutlet weak var dice5Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change the back button to say "Quit" instead
        let backButton = UIBarButtonItem()
        backButton.title = "Quit"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let nib = UINib(nibName: "TripleGameCell", bundle: nil)
        scoresTableView.register(nib, forCellReuseIdentifier: "tripleScoreCell")
        
        scoresTableView.dataSource = self
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
    }
}

extension TripleGameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tripleScoreCell", for: indexPath) as? TripleGameCell else {
            fatalError()
        }
        
        let scoreLabel = cell.scoreLabel
        
        switch indexPath.row {
        case 0:
            scoreLabel?.setTitle(K.one, for: .normal)
        case 1:
            scoreLabel?.setTitle(K.two, for: .normal)
        case 2:
            scoreLabel?.setTitle(K.three, for: .normal)
        case 3:
            scoreLabel?.setTitle(K.four, for: .normal)
        case 4:
            scoreLabel?.setTitle(K.five, for: .normal)
        case 5:
            scoreLabel?.setTitle(K.six, for: .normal)
        case 6:
            scoreLabel?.setTitle(K.k3, for: .normal)
        case 7:
            scoreLabel?.setTitle(K.k4, for: .normal)
        case 8:
            scoreLabel?.setTitle(K.fh, for: .normal)
        case 9:
            scoreLabel?.setTitle(K.smstr, for: .normal)
        case 10:
            scoreLabel?.setTitle(K.lgstr, for: .normal)
        case 11:
            scoreLabel?.setTitle(K.ytz, for: .normal)
            cell.score2.isHidden = true
            cell.score3.isHidden = true
        case 12:
            scoreLabel?.setTitle(K.chnc, for: .normal)
        default:
            fatalError("Shouldn't be here!!!")
        }
        
        return cell
    }
}

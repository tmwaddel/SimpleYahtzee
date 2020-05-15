//
//  ViewController.swift
//  SimpleYahtzee
//
//  Created by Taylor Waddel on 13/05/20.
//  Copyright © 2020 Taylor Waddel. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func playSingleYahtzee(_ sender: UIButton) {
        performSegue(withIdentifier: "singleGameSegue", sender: nil)
    }
    
    @IBAction func playTripleYahtzee(_ sender: UIButton) {
        performSegue(withIdentifier: "tripleGameSegue", sender: nil)
    }
}


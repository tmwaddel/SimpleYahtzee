//
//  TripleGameViewController.swift
//  SimpleYahtzee
//
//  Created by Taylor Waddel on 17/05/20.
//  Copyright © 2020 Taylor Waddel. All rights reserved.
//

import UIKit

class TripleGameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change the back button to say "Quit" instead
        let backButton = UIBarButtonItem()
        backButton.title = "Quit"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

//
//  SecondViewController.swift
//  LodjinhaMarketPlace
//
//  Created by Elias Amigo on 20/01/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var developerName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let customFont = UIFont(name: "Pacifico-Regular", size: 48.0)
        appName.font = customFont
        appName.text = "A Lodjinha"
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

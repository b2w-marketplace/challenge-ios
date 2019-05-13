//
//  AboutViewController.swift
//  ALojinha
//
//  Created by Arlen on 11/05/19.
//  Copyright © 2019 Arlen Ricardo Pereira. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    // MARK: - Variables
    
    
    // MARK: - Interface
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "a Lodjinha"
        nameLabel.text = "Arlen Ricardo Pereira"
        dateLabel.text = "13 de maio de 2019"
    }
    
    // MARK: Functions

}

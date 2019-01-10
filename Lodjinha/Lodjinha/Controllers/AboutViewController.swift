//
//  File.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var developerNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.About
        configureViews()
    }

    func configureViews() {
        developerNameLabel.text = Constants.DeveloperName
        developerNameLabel.font = Font(.installed(.RobotoMedium), size: .standard(.menuItem)).instance
        developerNameLabel.textColor = .GreyishBrown
        dateLabel.text = Constants.DevelopmentDate
        dateLabel.font = Font(.installed(.RobotoLight), size: .standard(.subtitle)).instance
        dateLabel.textColor = .GreyishBrown
        titleLabel.text = Constants.AppTitle
        titleLabel.font = Font(.installed(.PacificoRegular), size: .standard(.logo)).instance
        titleLabel.textColor = .GreyishBrown
    }

}

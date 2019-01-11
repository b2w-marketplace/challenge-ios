//
//  LodjinhaNavigationViewController.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class LodjinhaNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = .WarmPurple
        navigationBar.tintColor = .WhiteTwo
        let titleFont = Font(.installed(.RobotoBold), size: .standard(.title)).instance
        navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.WhiteTwo,
                                              NSAttributedString.Key.font: titleFont]

        navigationBar.layer.masksToBounds = false
        navigationBar.layer.shadowColor = UIColor.Greyish.cgColor
        navigationBar.layer.shadowOpacity = 0.8
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.layer.shadowRadius = 2
    }

}

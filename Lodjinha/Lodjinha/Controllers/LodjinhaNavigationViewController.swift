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
    }

}

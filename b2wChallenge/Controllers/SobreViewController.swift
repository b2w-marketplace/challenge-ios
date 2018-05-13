//
//  SobreViewController.swift
//  b2wChallenge
//
//  Created by Felipe Mac on 11/5/18.
//  Copyright © 2018 Felipe Mac. All rights reserved.
//

import UIKit

class SobreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Utils.formatNavigationTitleFontWithDefaultStyle(view: self, description: "Sobre")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

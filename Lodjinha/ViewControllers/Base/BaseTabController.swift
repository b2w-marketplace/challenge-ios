//
//  BaseTabController.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import UIKit

class BaseTabController: UITabBarController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//
//  AboutViewController.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 27/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.titleView = nil
        self.tabBarController?.navigationItem.title = "Sobre"
    }

}

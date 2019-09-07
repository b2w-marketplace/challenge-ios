//
//  AboutView.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 07/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class AboutView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "Sobre"
    }
}

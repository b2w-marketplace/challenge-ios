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
        self.navigationController?.navigationBar.isTranslucent = false
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 86.0/255.0,
                                    green: 41.0/255.0,
                                    blue: 126.0/255.0,
                                    alpha: 1.0)
        self.navigationItem.title = "Sobre"
        nav?.tintColor = .white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        setNeedsStatusBarAppearanceUpdate()
    }
}

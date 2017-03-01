//
//  AboutViewController.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 3/1/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.checkTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.checkTitle()
    }
    
    private func checkTitle() {
        if UIDevice.current.userInterfaceIdiom == .phone && UIDevice.current.orientation.isLandscape {
            self.lblTitle.text = ""
        } else {
            self.lblTitle.text = "a Lodjinha"
        }
    }

}

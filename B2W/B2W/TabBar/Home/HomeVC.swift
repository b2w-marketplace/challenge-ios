//
//  HomeVC.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

protocol HomeVCDelegate {
    func didLoad()
}

class HomeVC: UIViewController {
    var delegate: HomeVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        
        delegate?.didLoad()
    }
}

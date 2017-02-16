//
//  ItemOfACategory.swift
//  Lojinha
//
//  Created by Rodrigo A E Miyashiro on 13/02/17.
//  Copyright © 2017 Rodrigo Miyashiro. All rights reserved.
//

import UIKit


class ItemsOfACategoryViewController: UIViewController {
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
    }
}

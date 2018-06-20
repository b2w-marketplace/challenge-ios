//
//  ProductsViewController.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    fileprivate var categoryId: Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        assertDependencies()
    }

}

extension ProductsViewController: Injectable {
    func inject(_ categoryId: Int) {
        self.categoryId = categoryId
    }
    
    func assertDependencies() {
        assert(categoryId != nil)
    }
}

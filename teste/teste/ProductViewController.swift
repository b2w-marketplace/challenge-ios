//
//  ProductViewController.swift
//  teste
//
//  Created by Rodrigo Marangoni on 29/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet var productView: ProductView!
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productView.configure(self.product)

    }
    @IBAction func doReserve(_ sender: Any) {
        
    }
    


}

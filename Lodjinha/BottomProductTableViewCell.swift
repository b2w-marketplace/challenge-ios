//
//  BottomProductTableViewCell.swift
//  Lodjinha
//
//  Created by Daniel Novio on 19/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

class BottomProductTableViewCell: UITableViewCell {

    @IBOutlet weak private var productDescription: UIWebView!
    
    override var customObject: Any! {
        didSet {
            guard let product = customObject as? Product else {
                return
            }
            
            productDescription.loadHTMLString(product.description!, baseURL: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//
//  UpperProductDetailsTableViewCell.swift
//  Lodjinha
//
//  Created by Daniel Novio on 19/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireImage

class UpperProductDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak private var thumbnail: UIImageView!

    @IBOutlet weak private var name: UILabel!
    
    override var customObject: Any! {
        didSet {
            guard let product = customObject as? Product else {
                return
            }
            
            if let path = product.imageUrl {
                Alamofire.request(path).responseImage(completionHandler: { (responseImage) in
                    if let image = responseImage.result.value {
                        self.thumbnail.image = image
                    }
                })
                name.text = product.name
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

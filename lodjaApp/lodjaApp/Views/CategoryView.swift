//
//  CategoryView.swift
//  lodjaApp
//
//  Created by Rodrigo Marangoni on 29/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit
import AlamofireImage

class CategoryView: UIView {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    
    func configureView(_ name: String?, catImage: String?) {
        self.categoryName.text = name;
        if let url = URL(string:catImage!) {
            self.categoryImage.af_setImage(withURL: url)
        }
    }


}

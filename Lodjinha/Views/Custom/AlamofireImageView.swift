//
//  AlamofireImageView.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class AlamofireImageView: UIImageView {
    
    func loadImageFor(url urlString: String, placeholderImg: UIImage?) {
        if let url = URL(string: urlString) {
            self.af_setImage(withURL: url, placeholderImage: placeholderImg, imageTransition: UIImageView.ImageTransition.crossDissolve(0.2), runImageTransitionIfCached: false)
        }
    }
    
}

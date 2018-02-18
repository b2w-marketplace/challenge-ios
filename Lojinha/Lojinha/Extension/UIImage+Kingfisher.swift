//
//  UIImage+Kingfisher.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 12/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView
{
    func download(image url: String)
    {
        guard let imgURL = URL(string: url) else {
            return
        }
        
        self.kf.indicator?.startAnimatingView()
        self.kf.setImage(with: ImageResource(downloadURL: imgURL), placeholder: UIImage(named: "image_placeholder"))
        self.kf.indicator?.stopAnimatingView()
    }
}

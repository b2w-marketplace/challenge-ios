//
//  BannerView.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 20/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit

protocol BannerTappedDelegate: class {
    func bannerTapped()
}

class BannerView: UIView {

    @IBOutlet weak var bannerImage: UIImageView!
     weak var delegate: BannerTappedDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        bannerImage.isUserInteractionEnabled = true
        bannerImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
       self.delegate?.bannerTapped()
    }
}

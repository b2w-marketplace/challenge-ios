//
//  BannerView.swift
//  Lodginha
//
//  Created by Ricardo Bailoni on 22/04/2018.
//  Copyright © 2018 Ricardo Bailoni. All rights reserved.
//

import UIKit

class BannerView: UIView {
    @IBOutlet weak var ivBanner: CustomImageView!
    var banner: Banner? {
        didSet {
            if let banner = banner {
                ivBanner.loadImageWithStringURL(stringURL: banner.urlImagem)
            }
        }
    }
}

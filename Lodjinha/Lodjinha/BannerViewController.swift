//
//  BannerViewController.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 10/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit
import Kingfisher

class BannerViewController: UIViewController {
    @IBOutlet weak var bannerIv: UIImageView!
    @IBOutlet weak var bannerLinkBtn: UIButton!
    
    var banner: BannerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerIv.kf.setImage(with: banner?.imageUrl)
    }
    
    @IBAction func bannerPressed(_ sender: UIButton) {
        if let link = self.banner?.linkUrl {
            UIApplication.shared.openURL(link)
        }
    }
}

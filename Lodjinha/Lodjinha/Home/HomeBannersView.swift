//
//  HomeBannersView.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 25/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class HomeBannersView: UIView {

    private(set) var bannersCount: Int = 0
 
    func updateBanners(banners: [String]) {
        bannersCount = banners.count
    }
    
}

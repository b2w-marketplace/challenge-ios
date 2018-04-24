//
//  BannerManager.swift
//  Lodginha
//
//  Created by Ricardo Bailoni on 22/04/2018.
//  Copyright © 2018 Ricardo Bailoni. All rights reserved.
//

import Foundation

protocol BannerManagerDelegate {
    func finishLoadBanners(manager: BannerManager, result: BannersResult)
}

class BannerManager {
    lazy var bannerSinc: BannerSinc = {
        return BannerSinc()
    }()
    var delegate: BannerManagerDelegate?
    func showBanners() {
        bannerSinc.delegate = self
        bannerSinc.getBanners()
    }
}

extension BannerManager: BannerSincDelegate {
    func finishRequestBanner(banner: BannerSinc, result: BannersResult) {
        delegate?.finishLoadBanners(manager: self, result: result)
    }
}

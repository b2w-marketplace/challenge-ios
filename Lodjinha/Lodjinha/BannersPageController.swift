//
//  BannersPageController.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 10/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

class BannersPageController: UIPageViewController {
    private var bannerControllers = [UIViewController]()
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        LodjinhaAPI.getHomeBanners { (banners) in
            if let bannersList = banners {
                self.reloadControllers(forBanners: bannersList)
            }
        }
    }
    
    private func reloadControllers(forBanners banners: [BannerModel]) {
        var controllers = [UIViewController]()
        for banner in banners {
            if let bannerController = self.storyboard?.instantiateViewController(withIdentifier: "BannerViewController") as? BannerViewController {
                bannerController.banner = banner
                controllers.append(bannerController)
            }
        }
        
        self.bannerControllers = controllers
        if let firstBannerController = controllers.first {
            self.setViewControllers([firstBannerController], direction: .forward, animated: false, completion: nil)
            self.currentIndex = 0
        }
    }
}

extension BannersPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard self.bannerControllers.count > 1, var index = self.bannerControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        index = (index-1 >= 0) ? index-1 : self.bannerControllers.count-1
        currentIndex = index
        return self.bannerControllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard self.bannerControllers.count > 1, var index = self.bannerControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        index = (index+1 >= self.bannerControllers.count) ? 0 : index+1
        currentIndex = index
        return self.bannerControllers[index]
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return self.bannerControllers.count
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return currentIndex
//    }
}

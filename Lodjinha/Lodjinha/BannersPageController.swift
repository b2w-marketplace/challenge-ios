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
    private weak var scrollTimer: Timer?
    
    deinit {
        scrollTimer?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        LodjinhaAPI.getHomeBanners { (banners) in
            if let bannersList = banners {
                self.reloadControllers(forBanners: bannersList)
            }
        }
    }
    
    private func scheduleScrollTimer() {
        self.scrollTimer?.invalidate()
        guard !bannerControllers.isEmpty else {
            return
        }
        self.scrollTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(moveToNextController), userInfo: nil, repeats: true)
    }
    
    @objc private func moveToNextController() {
        guard let controller = self.viewControllers?.first, var index = self.bannerControllers.firstIndex(of: controller) else {
            return
        }
        
        let newIndex = (index + 1).quotientAndRemainder(dividingBy: bannerControllers.count).remainder
        if newIndex != index {
            let newController = self.bannerControllers[newIndex]
            self.setViewControllers([newController], direction: .forward, animated: true, completion: nil)
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
        }
        self.scheduleScrollTimer()
    }
}

// MARK: Datasource
extension BannersPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard self.bannerControllers.count > 1, var index = self.bannerControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        index = (index-1 >= 0) ? index-1 : self.bannerControllers.count-1
        return self.bannerControllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard self.bannerControllers.count > 1, var index = self.bannerControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        index = (index+1 >= self.bannerControllers.count) ? 0 : index+1
        return self.bannerControllers[index]
    }
}

// MARK: Delegate
extension BannersPageController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.scrollTimer?.invalidate()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.scheduleScrollTimer()
    }
}

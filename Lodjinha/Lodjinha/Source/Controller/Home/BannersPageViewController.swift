//
//  BannersPageViewController.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 10/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit

class BannersPageViewController: UIPageViewController {
    // MARK: - Outlets
    
    // MARK: - Properties
    private var bannersControllers : [UIViewController] = []
    private var banners : [Banner]?
    private let homeManager = HomeManager(maxConcurrentOperationCount: 200)
    private var pageControl = UIPageControl()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBanners()
    }
    
    // MARK: - General Methods
    private func setupPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: view.frame.maxY - 24, width: view.frame.width,height: 15))
        pageControl.numberOfPages = banners?.count ?? 0
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        view.addSubview(pageControl)
        view.bringSubview(toFront: pageControl)
    }
    
    private func getViewController(withIdentifier identifier : String, andBanner banner : Banner) -> UIViewController {
        guard let bannerController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:identifier) as? BannerViewController else {
            return UIViewController()
        }
        
        bannerController.setBanner(banner)
        return bannerController
    }
    
    private func setupPageController() {
        banners?.forEach({ (banner) in
            bannersControllers.append(getViewController(withIdentifier: "BannerController", andBanner: banner))
        })
        if let firstViewController = bannersControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        setupPageControl()
    }
    
    private func loadBanners() {
        homeManager.fetchBanners { (banners) in
            self.banners = banners()?.data
            self.setupPageController()
            self.dataSource = self
            self.delegate = self
        }
    }
    
    // MARK: - Actions

}

extension BannersPageViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = bannersControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard bannersControllers.count > previousIndex else {
            return nil
        }
        
        return bannersControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = bannersControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard bannersControllers.count != nextIndex else {
            return nil
        }
        
        guard bannersControllers.count > nextIndex else {
            return nil
        }
        
        return bannersControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let pageContentViewController = pageViewController.viewControllers?[0] else {
            return
        }
        self.pageControl.currentPage = bannersControllers.index(of: pageContentViewController) ?? 0
    }
}

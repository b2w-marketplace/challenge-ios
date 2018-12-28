//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 26/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var homeTabBarItem: UITabBarItem!
    @IBOutlet weak var aboutTabBarItem: UITabBarItem!
    
    private lazy var homeViewController: HomeViewController = {
        return HomeViewController()
    }()
    
    private lazy var aboutViewController: AboutViewController = {
        return AboutViewController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeNavigationBar()
        setupTabBar()
    }

    private func setupTabBar() {
        tabBar.selectedItem = homeTabBarItem
        addViewController(homeViewController)
    }
    
    private func setupHomeNavigationBar() {
        if let navigationController = self.navigationController {
            let size = navigationController.navigationBar.frame.size
            let margin: CGFloat = 8
            let width = size.width
            let height = size.height - margin
            
            let logoImageView = UIImageView(image: UIImage(named: "logoNavbar"))
            logoImageView.contentMode = .scaleAspectFit
            logoImageView.frame = CGRect(x: 0, y: margin / 2, width: width, height: height)
            
            navigationItem.title = "Home"
            navigationItem.titleView = logoImageView
        }
    }

    private func addViewController(_ viewController: UIViewController) {
        if children.count > 0 {
            let childViewController = children.first!
            childViewController.willMove(toParent: nil)
            childViewController.view.removeFromSuperview()
            childViewController.removeFromParent()
        }
        
        addChild(viewController)
        scrollView.addSubview(viewController.view)
        
        viewController.view.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(scrollView.snp.height)
        }
        
        viewController.didMove(toParent: self)
    }

}

extension MainViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == homeTabBarItem {
            setupHomeNavigationBar()
            addViewController(homeViewController)
        } else {
            navigationItem.titleView = nil
            navigationItem.title = "Sobre"
            addViewController(aboutViewController)
        }
    }
    
}

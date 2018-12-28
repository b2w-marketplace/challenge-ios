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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addViewController(HomeViewController())
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

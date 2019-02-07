//
//  HomeVC.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

protocol HomeVCDelegate {
    func didLoad()
}

class HomeVC: UIViewController {
    var delegate: HomeVCDelegate?

    let limitProducts = UIDevice.current.userInterfaceIdiom == .pad ? 6 : 4
    
    @IBOutlet weak var bannerPageControl: UIPageControl!
    
    @IBOutlet weak var bannerCollection: UICollectionView!
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var productCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        delegate?.didLoad()
        
        bannerPageControl.currentPageIndicatorTintColor = UIColor.init(netHex: kAppColor)
        
        if #available(iOS 11.0, *) {
            bannerCollection.contentInsetAdjustmentBehavior = .never
        }
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.tabBarController?.tabBar.isTranslucent = false
    }
    
    func registerCells(){
        bannerCollection.register(UINib(nibName: kBannerCell, bundle: nil), forCellWithReuseIdentifier: kBannerCell)
        categoryCollection.register(UINib(nibName: kCategoryCell, bundle: nil), forCellWithReuseIdentifier: kCategoryCell)
        productCollection.register(UINib(nibName: kProductCell, bundle: nil), forCellWithReuseIdentifier: kProductCell)
    }
}

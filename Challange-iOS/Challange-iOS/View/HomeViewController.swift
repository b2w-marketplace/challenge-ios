//
//  ViewController.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 19/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var mostSellerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        
    }

    func setupNavigation() {
        
        self.navigationItem.titleView = self.setupNavigationView()
    }
    
    

}


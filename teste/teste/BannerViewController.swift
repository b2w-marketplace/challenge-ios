//
//  BannerViewController.swift
//  teste
//
//  Created by Rodrigo Marangoni on 26/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController {

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageControl.numberOfPages = 5;

        // Do any additional setup after loading the view.
    }

    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        self.pageControl.currentPage-=1;
    }
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        self.pageControl.currentPage+=1;
    }
}

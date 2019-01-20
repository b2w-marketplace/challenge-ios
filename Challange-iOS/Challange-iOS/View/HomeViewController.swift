//
//  ViewController.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 19/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var mostSellerView: UIView!
    
    var viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        setupNavigation()
        viewModel.getBanners()
        callBacks()
        
    }

    func setupNavigation() {
        
        self.navigationItem.titleView = self.setupNavigationView()
    }
    
    func callBacks() {
        
        viewModel.banners.asObservable()
            .bind { (_) in
                self.setupSlideScrollView(banner: self.viewModel.createImageViewBanner(width: self.view.frame.width))
            }.disposed(by: disposeBag)
        
    }
    
    func setupSlideScrollView(banner: [BannerView]) {
        
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(banner.count), height: 180)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< banner.count {
            banner[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: 180)
            scrollView.addSubview(banner[i])
        }
    }
    

}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        viewModel.pageIndex.accept(pageControl.currentPage)
    }
}


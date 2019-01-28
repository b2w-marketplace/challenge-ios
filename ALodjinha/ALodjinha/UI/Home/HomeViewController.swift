//
//  HomeViewController.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 25/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit
import PKHUD
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var bestSellersTableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRx()
        setupEffects()
        setupBanner()
        
        HUD.show(.progress)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarConfiguration()
    }
    
    func setupRx() {
        
        viewModel.categoryArray.bind(to: categoriesCollectionView.rx.items(cellIdentifier: "Category", cellType: CategoryTableViewCell.self)) { (row, element, cell) in
            cell.setup(model: element)
            HUD.hide()
            }.disposed(by: disposeBag)
        
        viewModel.bestSellerArray.bind(to: bestSellersTableView.rx.items(cellIdentifier: "Product", cellType: ProductTableViewCell.self)) { (row, element, cell) in
            cell.setup(model: element)
            HUD.hide()
            }.disposed(by: disposeBag)
        
        categoriesCollectionView.rx.modelSelected(CategoryModel.self).subscribe(onNext: { [weak self] categorySelected in
            self?.performSegue(withIdentifier: "showList", sender: categorySelected)
        }).disposed(by: disposeBag)
        
        bestSellersTableView.rx.modelSelected(ProductModel.self).subscribe(onNext: { [weak self] productSelected in
            self?.performSegue(withIdentifier: "showDetail", sender: productSelected)
        }).disposed(by: disposeBag)
        
        viewModel.bannerArray.asObservable().subscribe(onNext: { [weak self] banners in
            self?.setupScrollViewWith(banners)
            HUD.hide()
        }).disposed(by: disposeBag)
        
        scrollView.rx.didScroll.subscribe({ _ in
            let pageIndex = round(self.scrollView.contentOffset.x/self.view.frame.width)
            self.pageControl.currentPage = Int(pageIndex)
        }).disposed(by: disposeBag)
        
        let tapGesture = UITapGestureRecognizer()
        scrollView.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { [weak self] recognizer in
            self?.openBannerUrl()
        }).disposed(by: disposeBag)
        
    }
    
    func setupScrollViewWith(_ banners: [BannerModel]) {
        for view in scrollView.subviews {
            view.removeFromSuperview()
        }
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scrollView.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(banners.count), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< banners.count {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: scrollView.frame.height)
            let url = URL(string: banners[i].urlImage)
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder.jpg"))
            scrollView.addSubview(imageView)
        }
        
        pageControl.numberOfPages = banners.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl ?? UIView())
    }
    
    func navigationBarConfiguration() {
        let image = UIImage(named: "logoNavbar")
        self.tabBarController?.navigationItem.titleView = UIImageView(image: image)
    }
    
    func setupEffects() {
        categoriesCollectionView.layer.borderColor = UIColor.lightGray.cgColor
        categoriesCollectionView.layer.borderWidth = 0.5
    }
    
    func setupBanner() {
        
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        
    }
    
    func openBannerUrl() {
        let banner = viewModel.bannerArray.value[pageControl.currentPage]
        guard let url = URL(string: banner.linkUrl) else { return }
        UIApplication.shared.open(url)
        
    }
    
    @objc func moveToNextPage() {
        let pageWidth = self.scrollView.frame.width
        let maxWidth = Int(pageWidth) * viewModel.bannerArray.value.count
        let contentOffset = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  Int(contentOffset + pageWidth) == maxWidth
        {
            slideToX = 0
        }
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showList" {
            let viewController = segue.destination as! CategoryViewController
            viewController.viewModel.category = (sender as! CategoryModel)
        } else if segue.identifier == "showDetail" {
            let viewController = segue.destination as! ProductViewController
            viewController.viewModel.product.accept((sender as! ProductModel))
        }
    }

}

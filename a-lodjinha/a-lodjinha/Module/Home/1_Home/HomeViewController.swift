//
//  ViewController.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/17/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomePresenterDelegate, UIScrollViewDelegate,
UICollectionViewDelegate, UICollectionViewDataSource, ProductTableViewControllerDelegate {

    var presenter : HomePresenter?
    var banners: [Banner] = []
    var categories: [Category] = []
    var productTableViewController: ProductTableViewController?
//    var bestSellers: [Products] = []
    
    @IBOutlet weak var bannersScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var bestSellerViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = HomeRouter.viewController(vc: self)
        
        self.title = "Home"
        
        self.presenter?.delegate = self
        self.bannersScrollView.delegate = self
        
        self.categoriesCollectionView.dataSource = self
        self.categoriesCollectionView.delegate = self
        
        self.load()
    }

    func load() {
        self.showLoading(loading: true)
        
        self.presenter?.getBanners()
        self.presenter?.getCategories()
        
        self.initBestSellerView()
    }
    
    func initBestSellerView() {
        
        self.productTableViewController = ProductRouter.tableViewController()
        
        self.productTableViewController?.delegate = self
        
        self.productTableViewController?.modeList = .bestSeller
        
        guard let view = self.productTableViewController?.view else {
            return
        }
        
        var frame = view.frame
        frame.size.height = self.bestSellerViewContainer.frame.height
        frame.size.width = self.bestSellerViewContainer.frame.width - 15
        frame.origin.y = 0
        frame.origin.x = 10
        view.frame = frame
        
        self.bestSellerViewContainer.addSubview(view)
        
    }
    
    func checkFinishLoading() {
        if self.banners.count > 0 &&
            self.categories.count > 0 {
            self.showLoading(loading: false)
        }
    }
    
    // MARK HomePresenterDelegate
    
    func showBanners(banners: [Banner]) {
        self.banners = banners
        self.updateScrollView()
        self.checkFinishLoading()
    }
    
    func showCategories(categories: [Category]) {
        self.categories = categories
        self.categoriesCollectionView.reloadData()
        self.checkFinishLoading()
    }
    
    func showLoading(loading: Bool) {
        if loading {
            LoadingViewController.shared.show()
        } else {
            LoadingViewController.shared.dismiss()
        }
    }
    
    func showConnectionError() {
        ConnectionErrorController.shared.showConnectionError(target: self, action: #selector(update))
    }
    
    func update() {
        ConnectionErrorController.shared.dismissConnectionError()
        self.load()
    }
    
    // MARK: ScrollView
    
    func updateScrollView() {

        for i in 0..<self.banners.count {
            let imageView = UIImageView()
            let x = self.bannersScrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: x, y: 0, width: self.bannersScrollView.frame.width, height: self.bannersScrollView.frame.height)
            
            AlamofireImageNetworking().requestImage(url: self.banners[i].urlImagem, success: { (image) in
                imageView.image = image
            }) { (error) in
                imageView.image = nil
            }

            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
            imageView.contentMode = .scaleToFill
            
            self.bannersScrollView.addSubview(imageView)
            self.bannersScrollView.contentSize.width = self.bannersScrollView.frame.size.width * CGFloat(i + 1)
            
        }

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.pageControl.currentPage = Int(pageNumber)
    }
    
    
    // MARK: CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell",
                                                                          for: indexPath) as! CategoryCollectionViewCell
        
        if !self.categories.indices.contains(indexPath.row) {
            return cell
        }
        
        cell.labelDescription.text = self.categories[indexPath.row].description
        AlamofireImageNetworking().requestImage(url: self.categories[indexPath.row].urlImagem, success: { (image) in
            cell.image.image = image
        }) { (error) in
            cell.image = nil
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.presenter?.callProductList(categoryID: self.categories[indexPath.row].id,
                                        categoryName:self.categories[indexPath.row].description)
    
    }
    
    // MARK: ProductTableViewControllerDelegate
    func showDetail(product: Product) {
        self.presenter?.callDetails(product: product)
    }
    
}


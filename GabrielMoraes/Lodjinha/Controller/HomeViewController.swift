//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    @IBOutlet weak var collectionCategory: UICollectionView!
    @IBOutlet weak var collectionBanner: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var banners = [Banner]()
    var categories = [Category]()
    var products = [Product]()
    var requests = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: Constants.identifierProduct, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: Constants.identifierProduct)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(loadContent), for: .valueChanged)
        self.refreshControl?.beginRefreshing()
        
        self.loadContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            self.collectionBanner.collectionViewLayout.invalidateLayout()
            self.collectionBanner.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
            self.pageControl.currentPage = 0
        }) { context in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadContent() {
        self.requests = 3
        self.listBanners()
        self.listCategories()
        self.listBestSellers()
    }
    
    func checkRequests() {
        self.requests -= 1
        if self.requests == 0 {
            self.refreshControl?.endRefreshing()
        }
    }
    
    func listBanners() {
        let url = Constants.urlBanners
        Service.requestArray(with: url) { (requestObject: [Banner]?, errorMessage: String?) in
            if let banners = requestObject {
                self.banners = banners
                self.collectionBanner.reloadData()
            }
            self.checkRequests()
        }
    }
    
    func listCategories() {
        let url = Constants.urlCategories
        Service.requestArray(with: url) { (requestObject: [Category]?, errorMessage: String?) in
            if let categories = requestObject {
                self.categories = categories
                self.collectionCategory.reloadData()
            }
            self.checkRequests()
        }
    }
    
    func listBestSellers() {
        let url = Constants.urlBestSellers
        Service.requestArray(with: url) { (requestObject: [Product]?, errorMessage: String?) in
            if let products = requestObject {
                self.products = products
                self.tableView.reloadData()
            }
            self.checkRequests()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Strings.homeSectionBestSellers
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifierProduct, for: indexPath) as! ProductCell
        cell.product = self.products[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabBarController?.tabBar.isHidden = true
        let product = self.products[indexPath.item]
        product.showDetail(from: self)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = self.collectionBanner.indexPathsForVisibleItems.first {
            self.pageControl.currentPage = indexPath.item
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.tabBarController?.tabBar.isHidden = true
        if segue.identifier == Constants.segueProductList {
            let controller = segue.destination as! ProductListViewController
            controller.category = sender as! Category
        }
    }

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count: Int
        if collectionView == self.collectionBanner {
            count = self.banners.count
            self.pageControl.numberOfPages = count
        } else {
            count = self.categories.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionBanner {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
            cell.banner = self.banners[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.category = self.categories[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionBanner {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else {
            return CGSize(width: 110.0, height: collectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionBanner {
            let banner = self.banners[indexPath.item]
            UIApplication.shared.openURL(banner.linkUrl)
        } else {
            let category = self.categories[indexPath.item]
            self.performSegue(withIdentifier: Constants.segueProductList, sender: category)
        }
    }
    
}

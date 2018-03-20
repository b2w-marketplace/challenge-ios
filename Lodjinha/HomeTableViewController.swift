//
//  HomeTableViewController.swift
//  Lodjinha
//
//  Created by Daniel Novio on 19/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireImage

class HomeTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak private var pageControl: UIPageControl!
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var bannerActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var bannerLoadingLabel: UILabel!
    @IBOutlet weak private var innerCollectionView: UICollectionView!
    
    var banners: [Banner]?
    var categories: [Category]?
    var products: [Product]?
    
    var selectedCategory: Category?
    var selectedProductId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarAppearence()
        
        setupData()
    }
    
    func setupNavBarAppearence() {
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Pacifico-Regular", size: 20.0)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        
        let navBarLogo = UIImageView(image: UIImage(named: "Navbar Logo"))
        self.navigationItem.titleView = navBarLogo
    }
    
    func setupData() {
        requestBanners()
        requestCategories()
        requestProducts()
    }

    func requestBanners() {
        pageControl.isHidden = true
        
        DataHandler.instance.getBanners(sucessBlock: { (bannersList) in
            self.banners = bannersList
            
            NSLog("Yay, have banners here")

            self.setupBannerUI()
        }) { (errorMessage) in
            self.presentDefaultAlert(withTitle: errorMessage, andMessage: nil, handler: nil)
        }
    }

    //MARK: Banner stuff

    func setupBannerUI() {
        guard let banners = banners else {
            return
        }
        pageControl.isHidden = false
        bannerActivityIndicator.stopAnimating()
        bannerLoadingLabel.isHidden = true
        
        var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)

        for index in 0..<banners.count {
            let banner = banners[index]

            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            
            let imageView = UIImageView(frame: frame)
            
            if let path = banner.imageUrl {
                Alamofire.request(path).responseImage(completionHandler: { (responseImage) in
                    if let image = responseImage.result.value {
                        imageView.image = image
                    }
                })
            }
            
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width*CGFloat(banners.count), height: self.scrollView.frame.size.height)
        pageControl.numberOfPages = banners.count
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Categ/Collection stuff
    
    func requestCategories() {
        DataHandler.instance.getCategories(sucessBlock: { (categoryList) in
            self.categories = categoryList
            
            NSLog("Yay, have categs here")
            
            self.innerCollectionView.reloadData()
            
        }) { (errorMessage) in
            self.presentDefaultAlert(withTitle: errorMessage, andMessage: nil, handler: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let categories = categories else {
            return 1
        }
        
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let categories = categories else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "Loading Cell", for: indexPath)
        }
        
        let cell: InnerCategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category Cell", for: indexPath) as! InnerCategoryCollectionViewCell
        
        cell.customObject = categories[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories?[indexPath.row]

        performSegue(withIdentifier: "Product List Segue", sender: self)
    }
    
    //MARK: Product stuff
    
    func requestProducts() {
        DataHandler.instance.getMostSelledProducts(sucessBlock: { (productList) in
            //
            self.products = productList
            
//            self.tableView.reloadSections([1], with: .automatic) //this is not working in Plus devices for some weird reason...
            self.tableView.reloadData()
            
        }) { (errorMessage) in
            self.presentDefaultAlert(withTitle: errorMessage, andMessage: nil, handler: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if products == nil || products?.count == 0 {
            if indexPath.section == 1 && (indexPath.row == 1 || indexPath.row == 2) {
                return 0.0
            }
            
        } else {
            if indexPath.section == 1 && indexPath.row == 0 {
                return 0.0
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            guard let products = products else {
                return super.tableView(tableView, cellForRowAt: indexPath)
            }
            
            if indexPath.row != 0 {
                let cell = super.tableView(tableView, cellForRowAt: indexPath) as! ProductTableViewCell
                cell.customObject = products[indexPath.row]
                
                return cell
            }
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let selectedProduct = products![indexPath.row]
            selectedProductId = selectedProduct.id!
            
            performSegue(withIdentifier: "Product Details Segue", sender: self)
        }
    }

    //MARK: Segue things
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.fixBackButtonTitle()
        
        if segue.identifier == "Product List Segue" {
            let productListViewController = segue.destination as! ProductListTableViewController
            productListViewController.category = selectedCategory
            
        } else if segue.identifier == "Product Details Segue" {
            let productDetailsVC = segue.destination as! ProductDetailsViewController
            productDetailsVC.productId = selectedProductId
            
        }
    }
}

extension UINavigationItem {
    func fixBackButtonTitle() {
        let backItem = UIBarButtonItem()
        backItem.title = "Voltar"
        self.backBarButtonItem = backItem
    }
}

extension UIViewController {
    func presentDefaultAlert(withTitle title: String?, andMessage message: String?, handler:((_: UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: handler)

        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

//
//  HomeViewController.swift
//  Lojinha
//
//  Created by Rodrigo A E Miyashiro on 11/02/17.
//  Copyright © 2017 Rodrigo Miyashiro. All rights reserved.
//

import UIKit
import JSONJoy

class HomeViewController: UIViewController
{
    
    // MARK: - Lets and Vars
    var banners = [Banner]()
    var categories = [Category]()
    var productsBestSellers = [Product]()
    let notificationName = Notification.Name("showTableViewNotificationIdentifier")
    
    var isBannerLoading = false
    var isCategoryLoading = false
    var isBestSellerLoading = false
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Pacifico", size: 25)!, NSForegroundColorAttributeName: UIColor.white]
        
        self.homeTableView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(showTableView), name: notificationName, object: nil)
        
        loadingDataHome()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
        
    
    func loadingDataHome()
    {
        spinner.startAnimating()
        
        loadingBanner()
        loadingCategories()
        loadingBestSellers()
    }
    
    func loadingBanner()
    {
        let url = URL.loja() + Service.banner.rawValue
        Request.get(url: url) { (bannerData) in
            do
            {
                let allBanner = JSONDecoder(bannerData)["data"].getOptionalArray()
                for banner in allBanner! {
                    let newBanner = try Banner(banner)
                    self.banners.append(newBanner)
                }
                self.isBannerLoading = true
                NotificationCenter.default.post(name: self.notificationName, object: nil)
            }
            catch
            {
                print("Banner Request Error!!!")
            }
        }
    }
    
    func loadingCategories()
    {
        let url = URL.loja() + Service.category.rawValue
        Request.get(url: url) { (categoryData) in
            do
            {
                let allCategories = JSONDecoder(categoryData)["data"].getOptionalArray()
                for category in allCategories!
                {
                    let newCategory = try Category(category)
                    self.categories.append(newCategory)
                }
                self.isCategoryLoading = true
                NotificationCenter.default.post(name: self.notificationName, object: nil)
            }
            catch
            {
                print("Category Request Error!!!")
            }
        }
    }
    
    
    func loadingBestSellers()
    {
        let url = URL.loja() + Service.product.rawValue + Service.bestSeller.rawValue
        Request.get(url: url) { (bestSellersData) in
            do
            {
                let allBestSellers = JSONDecoder(bestSellersData)["data"].getOptionalArray()
                for bestSeller in allBestSellers!
                {
                    let newBestSeller = try Product(bestSeller)
                    self.productsBestSellers.append(newBestSeller)
                }
                self.isBestSellerLoading = true
                NotificationCenter.default.post(name: self.notificationName, object: nil)
            }
            catch
            {
                print("Best Seller Request Error!!!")
            }
        }
    }

    
    func showTableView(notification: Notification) {
        if isBannerLoading && isCategoryLoading && isBestSellerLoading {
            self.spinner.stopAnimating()
            self.homeTableView.isHidden = false
            self.homeTableView.reloadData()
            
            isBestSellerLoading = false
            isCategoryLoading = false
            isBestSellerLoading = false
        }
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

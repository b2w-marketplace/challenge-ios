//
//  ListViewController.swift
//  Challenge-ios
//
//  Created by Roberto Luiz Veiga Junior on 16/02/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var acMore: UIActivityIndicatorView!
    @IBOutlet weak var lbNoProducts: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var category: Category!
    var products = [Product]()
    var moreProducts = [Product]()
    var totalProducts : Int!
    let SGDETAILFROMCATEGORY = "sgDetailFromCategory"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCommon()
    }
    
    func initCommon() {
        self.loadListCategory()
        self.title = category.description
    }
    
    func noProducts() {
        if self.products.count == 0 {
            self.lbNoProducts.isHidden = false
            self.tableView.separatorStyle = .none
        } else {
            self.lbNoProducts.isHidden = true
        }
    }
    
    
    fileprivate func loadListCategory() {
        Product().getProductsByCategoryId(categoryId: category.id) { productsResult, moreProductsResult in
            self.acMore.stopAnimating()
            self.products = productsResult
            self.moreProducts = moreProductsResult
            self.totalProducts = self.products.count+self.moreProducts.count
            self.noProducts()
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLPRODUCTBYCATEGORY") as! ProductTableViewCell
        let product = self.products[indexPath.row]
        cell.load(product: product)
        self.acMore.stopAnimating()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.products[indexPath.row]
        self.performSegue(withIdentifier: self.SGDETAILFROMCATEGORY, sender: item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentSize.height >= tableView.frame.size.height {
            if(tableView.contentOffset.y >=
                (tableView.contentSize.height - tableView.frame.size.height)) {
                if self.products.count < (self.totalProducts) {
                    self.acMore.startAnimating()
                    self.products.append(contentsOf: self.moreProducts)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.SGDETAILFROMCATEGORY {
            let view = segue.destination as! DetailViewController
            view.product = sender as! Product
        }
    }
}

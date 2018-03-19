//
//  ProductListTableViewController.swift
//  Lodjinha
//
//  Created by Daniel Novio on 19/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

class ProductListTableViewController: UITableViewController {
    
    var categoryId: Int?
    
    var products: [Product]?
    
    var selectedProduct: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }

    func setupData() {
        DataHandler.instance.getProducts(with: categoryId, sucessBlock: { (productList) in
            self.products = productList
            
            self.tableView.reloadSections([0], with: .automatic) //cooler than regular reloadData
        }) { (errorMessage) in
            //
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let products = products else {
            return 1
        }
        
        return products.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if products == nil || products?.count == 0 {
            return 90.0
        }
        return 105.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let products = products else {
            return tableView.dequeueReusableCell(withIdentifier: "Loading Cell", for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath) as! ProductTableViewCell
        cell.customObject = products[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = products![indexPath.row]
        
        performSegue(withIdentifier: "Product Details Segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Product Details Segue" {
            let productDetailsVC = segue.destination as! ProductDetailsViewController
            
            productDetailsVC.productId = selectedProduct?.id
        }
    }
}

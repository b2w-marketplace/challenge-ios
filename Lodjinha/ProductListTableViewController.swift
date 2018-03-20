//
//  ProductListTableViewController.swift
//  Lodjinha
//
//  Created by Daniel Novio on 19/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

class ProductListTableViewController: UITableViewController {
    
    var category: Category!
    
    var products: [Product]?
    
    var selectedProduct: Product?
    
    var loadingNewData: Bool = false
    
    var endOfItems: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = category.description
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        setupData()
    }
    
    func setupData() {
        DataHandler.instance.getProducts(withCategoryId: category.id, productOffset: 0, sucessBlock: { (productList) in
            self.products = productList
            
            if self.products?.count == 0 {
                
                self.presentDefaultAlert(withTitle: "Desculpe, não encontramos produtos para essa categoria", andMessage: nil, handler: { (action) in
                    self.navigationController?.popToRootViewController(animated: true)
                })
            }
            
            self.tableView.reloadData()
            
        }) { (errorMessage) in
            self.presentDefaultAlert(withTitle: errorMessage, andMessage: nil, handler: nil)
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
        
        if loadingNewData {
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

    //MARK: Load more methods
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let products = products else {
            return
        }
        
        let lastElement = products.count - 1
        
        if !loadingNewData && indexPath.row == lastElement && !endOfItems {
            loadingNewData = true
            loadMore()
        }
    }
    
    func loadMore() {
        DataHandler.instance.getProducts(withCategoryId: category.id, productOffset: products?.count, sucessBlock: { (productList) in
            guard let productList = productList else {
                self.loadingNewData = false
                self.endOfItems = true
                
                self.tableView.reloadData()
                
                return
            }
            
            if productList.count > 0 {
                self.products! += productList
                self.loadingNewData = false
                
                self.tableView.reloadData()
            } else {
                self.loadingNewData = false
                self.endOfItems = true

                self.tableView.reloadData()
            }
        }) { (errorMessage) in
            self.loadingNewData = false
            
            self.presentDefaultAlert(withTitle: errorMessage, andMessage: errorMessage, handler: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.fixBackButtonTitle()
        
        if segue.identifier == "Product Details Segue" {
            let productDetailsVC = segue.destination as! ProductDetailsViewController
            productDetailsVC.productId = selectedProduct?.id
        }

    }
}

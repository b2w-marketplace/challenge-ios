//
//  ProductListViewController.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

class ProductListViewController: UITableViewController {
    
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    var category: Category!
    var products = [Product]()
    var finished = false
    var limit = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.indicator)
        self.navigationItem.title = self.category.desc
        
        let nib = UINib(nibName: Constants.identifierProduct, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: Constants.identifierProduct)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(reload), for: .valueChanged)
        self.refreshControl?.beginRefreshing()
        self.refreshControl?.layoutIfNeeded()
        self.tableView.contentOffset = CGPoint(x: 0, y: -self.refreshControl!.frame.size.height)
        
        self.listProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        self.finished = false
        self.listProducts()
    }
    
    func listProducts(paginate: Bool = false) {
        let offset: Int
        if paginate {
            offset = self.products.count
        } else {
            offset = 0
        }
        let params = [
            "offset": offset,
            "limit": self.limit,
            "categoriaId": category.id
        ]
        let url = Constants.urlProduct
        Service.requestArray(with: url, params: params) { (requestObject: [Product]?, errorMessage: String?) in
            if let products = requestObject {
                let empty = products.count == 0
                if paginate {
                    if empty {
                        self.finished = true
                    } else {
                        self.products.append(contentsOf: products)
                    }
                } else if empty {
                    self.showAlert(with: Strings.infoNoResults)
                } else {
                    self.products = products
                }
                self.tableView.reloadData()
            }
            self.indicator.stopAnimating()
            self.refreshControl?.endRefreshing()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifierProduct, for: indexPath) as! ProductCell
        cell.product = self.products[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let index = indexPath.item + 1
        if index % self.limit == 0 && index == self.products.count && !self.finished {
            self.indicator.startAnimating()
            self.listProducts(paginate: true)
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

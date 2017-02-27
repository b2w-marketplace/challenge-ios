//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categories = [Category]()
    var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: Constants.identifierProduct, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: Constants.identifierProduct)
        
        self.listCategories()
        self.listBestSellers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func listCategories() {
        let url = Constants.urlCategories
        Service.requestArray(with: url) { (requestObject: [Category]?, errorMessage: String?) in
            if let categories = requestObject {
                self.categories = categories
                self.collectionView.reloadData()
            } else {
                
            }
        }
    }
    
    func listBestSellers() {
        let url = Constants.urlBestSellers
        Service.requestArray(with: url) { (requestObject: [Product]?, errorMessage: String?) in
            if let products = requestObject {
                self.products = products
                self.tableView.reloadData()
            } else {
                
            }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCel", for: indexPath) as! CategoryCell
        cell.category = self.categories[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

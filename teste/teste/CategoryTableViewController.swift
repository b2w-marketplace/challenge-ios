//
//  CategoryTableViewController.swift
//  teste
//
//  Created by Rodrigo Marangoni on 30/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class CategoryTableViewController: UITableViewController {
    var produtos: Array<Product> = []
    var categoryID: Int!
    private let pageSize = 20
    private var currentOffset = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        self.getCategoryProducts(offset: self.currentOffset)
        self.tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")

    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.produtos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row/(self.currentOffset-1) > 0 {
            self.getCategoryProducts(offset: self.pageSize)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = self.produtos[indexPath.row]
        
        cell.configureCell(product)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "pushToProductDetail", sender: self.produtos[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToProductDetail" {
            let dest = segue.destination as! ProductViewController
            dest.product = sender as! Product
        }
    }
    
    func getCategoryProducts(offset: Int) {
        let categoryURL = "\(APPURL.GetProduto)?offset=\(offset)&limit=\(String(self.pageSize))&categoriaId=\(String(self.categoryID))"
        
        Alamofire.request(categoryURL, method: .get).validate().responseObject { (response: DataResponse<ProductData>) in
            switch response.result {
            case .success(let value):
                self.produtos.append(contentsOf: value.data!)
                self.currentOffset += self.pageSize
                self.tableView.reloadData()
                print("JSON: \(self.produtos)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

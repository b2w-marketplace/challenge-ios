//
//  TopSellerTableViewController.swift
//  teste
//
//  Created by Rodrigo Marangoni on 26/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class TopSellerTableViewController: UITableViewController {
    
    private var produtos: Array<Product>!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getTopProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.produtos != nil {
            return self.produtos.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopSellerCell", for: indexPath) as! TopSellerCellTableViewCell
        let product = self.produtos[indexPath.row]
        
        cell.configureCell(product)
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "pushToProduct", sender: self.produtos[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToProduct" {
            let dest = segue.destination as! ProductViewController
            dest.product = sender as! Product
        }
    }
    
    func getTopProducts() {
        Alamofire.request(APPURL.GetMaisVendidos, method: .get).validate().responseObject { (response: DataResponse<ProductData>) in
            switch response.result {
            case .success(let value):
                self.produtos = value.data
                self.tableView.reloadData()
                print("JSON: \(self.produtos)")
            case .failure(let error):
                print(error)
            }
        }
    }

}

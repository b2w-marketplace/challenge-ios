//
//  TopSellerTableViewController.swift
//  teste
//
//  Created by Rodrigo Marangoni on 26/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class TopSellerTableViewController: UITableViewController {
    
    private var produtos: Array<JSON>!

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
        // #warning Incomplete implementation, return the number of sections
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
        
        
        cell.configureCell(product["nome"].stringValue, de: product["precoDe"].floatValue, por: product["precoPor"].floatValue, imageUrl: product["urlImagem"].stringValue)
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected cell: %d\n",indexPath.row);
    }
    func getTopProducts() {
        Alamofire.request(APPURL.GetMaisVendidos, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonData = JSON(value)
                self.produtos = jsonData["data"].arrayValue
                self.tableView.reloadData()
                print("JSON: \(self.produtos)")
            case .failure(let error):
                print(error)
            }
        }
    }

}

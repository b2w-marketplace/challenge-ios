//
//  ProductViewController.swift
//  teste
//
//  Created by Rodrigo Marangoni on 29/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ProductViewController: UIViewController {
    @IBOutlet var productView: ProductView!
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productView.configure(self.product)
        self.title = self.product.nome

    }
    
    @IBAction func doReserve(_ sender: Any) {
        let finalURL = "\(APPURL.GetProduto)/\(String(self.product.prodId!))"
        let parameters = ["produtoId": String(self.product.prodId!)]
        
        Alamofire.request(
            finalURL,
            method: .post,
            parameters: parameters)
            .validate()
            .responseJSON { response in
                var message: String!
                switch response.result {
                case .success( _):
                    message = "Sucesso!"
                case .failure(let error):
                    message = "Erro: \(error)"
                }
                let alert = UIAlertController(title: "Reserva", message: message, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{(action) in
                    self.navigationController?.popViewController(animated: true)
                }))
                
                self.present(alert, animated: true)
        }
    }
}

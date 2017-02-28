//
//  ProductDetailViewController.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPriceOld: UILabel!
    @IBOutlet weak var lblPriceNew: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.product.category.desc
        
        self.imgProduct.kf.setImage(with: self.product.imageUrl)
        self.lblName.text = self.product.name
        self.lblPriceOld.text = Strings.productCellPriceOld + product.priceOld.asLocaleCurrency
        self.lblPriceNew.text = Strings.productCellPriceNew + product.priceNew.asLocaleCurrency
        self.lblDesc.attributedText = self.product.desc.utf8Data?.attributedString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reserveProduct(_ sender: RoundedButton) {
        sender.startLoading()
        let url = Constants.urlProduct
        Service.request(with: url) { errorMessage in
            if let message = errorMessage {
                self.showErrorAlert(with: message)
            } else {
                let alertController = UIAlertController(title: nil, message: Strings.productReservationSuccess, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { action in
                    print(self.navigationController?.popViewController(animated: true) ?? "View controller is nil")
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
            sender.stopLoading()
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

//
//  ProductViewController.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import UIKit
import Kingfisher




class ProductViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleProductLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var textProduct: UITextView!
    
    var product:Produto?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let product = product{
            DispatchQueue.main.async {
                let viewModel = ProudctViewModel(model: product)
                self.descriptionLabel.text = viewModel.descriptionLabel
                self.productImage.kf.setImage(with: viewModel.productImage)
                self.priceLabel.text = viewModel.priceLabel
                self.discountPriceLabel.text = viewModel.discountPriceLabel
                self.textProduct.text = viewModel.textProduct.string
                self.titleProductLabel.text = viewModel.titleProductLabel
            }
       
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    @IBAction func makeReservationButtonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        if let product = product{
            let viewModel = ProudctViewModel(model: product)
            viewModel.makeReservation { (status) in
                sender.isEnabled = true

                if status{
                    self.showOkAlert(title: "Item reservado", message: "Reserva feita com sucesso!", viewController: self)
                }else{
                         self.showOkAlert(title: "Ocorre um erro", message: "Por favor tente novamente", viewController: self)
                }
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

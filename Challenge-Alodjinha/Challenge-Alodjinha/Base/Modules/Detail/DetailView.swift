//
//  DetailView.swift
//  Challenge-Alodjinha
//
//  Created by Luis Henrique Tavares Ferreira on 17/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit
import Kingfisher

class DetailView: UIViewController {
    
    private var products = [Product]()
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var oldValueLabel: UILabel!
    @IBOutlet weak var newValueLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        fill()
    }
    
    func setup(transporter: ResultTransporterProduct, index: Int) {
        self.products = [transporter.product[index]]
    }
    
    func fill() {
        nameProductLabel.text = products[0].nome
        oldValueLabel.text = "De: \(String.doubleToString(products[0].precoDe))"
        newValueLabel.text = "Por: \(String.doubleToString(products[0].precoPor))"
        descriptionTextView.text = products[0].descricao
        if let url = URL(string: products[0].urlImagem) {
            productImage.kf.setImage(with: url)
        }
    }
    
    @IBAction func reserve() {
        self.showAlert(withTitle: "", message: "Produto Reservado com sucesso!")
    }

}

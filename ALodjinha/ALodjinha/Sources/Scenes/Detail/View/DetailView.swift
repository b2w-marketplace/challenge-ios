//
//  DetailView.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 06/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class DetailView: UIViewController {
    
    
    @IBOutlet weak var productImage: AlodjinhaImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceDeLabel: UILabel!
    @IBOutlet weak var pricePorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var bookButton: UIButton!
    
    private var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        fill()
        setupNavBar()
    }
    
    private func setupNavBar() {
        self.navigationItem.title = product?.categoria.descricao ?? ""
    }
    
    func setup(product: Product) {
        self.product = product
        print(product)
    }
    
    private func fill() {
        productImage.downloadImage(withUrl: product?.urlImagem ?? "")
        nameLabel.text = product?.nome ?? ""
        priceDeLabel.text = String("\(product?.precoDe ?? 0)")
        pricePorLabel.text = String("\(product?.precoPor ?? 0)")
        descriptionTextView.text = product?.descricao ?? ""
    }
}

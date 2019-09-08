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
    @IBOutlet weak var bookButton: UIButton! {
        didSet {
            bookButton.layer.cornerRadius = 8.0
        }
    }
    
    private var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        fill()
        setupNavBar()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationItem.title = product?.categoria.descricao ?? ""
    }
    
    func setup(product: Product) {
        self.product = product
        print(product)
    }
    
    private func fill() {
        productImage.downloadImage(withUrl: product?.urlImagem ?? "")
        nameLabel.text = product?.nome ?? ""
        priceDeLabel.attributedText = String().makeStrikeThroughText("De \(Double().formatTwoDecimal(value: product?.precoDe ?? 0))")
        pricePorLabel.text = "Por \(Double().formatTwoDecimal(value: product?.precoPor ?? 0))"
        descriptionTextView.text = product?.descricao ?? ""
    }
    
    @IBAction func actionBookButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "Produto reservado com sucesso", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (dismiss) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
}

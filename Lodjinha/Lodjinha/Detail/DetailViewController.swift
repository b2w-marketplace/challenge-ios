//
//  DetailViewController.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 28/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var productIndicator: UIActivityIndicatorView!
    
    private var titleName: String
    private var produtoId: Int
    private var product: Produto?
    
    init(titleName: String, produtoId: Int) {
        self.titleName = titleName
        self.produtoId = produtoId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupButton()
        setupTextView()
        loadProduct()
    }
    
    private func loadProduct() {
        Network.getProdutoDetalhes(produtoId: produtoId) { (response) in
            dump(response)
            inMainAsync {
                self.productIndicator.stopAnimating()
                self.product = response
                self.setupProductData()
            }
        }
    }
    
    private func setupProductData() {
        if let product = self.product {
            productImageView.kf.indicatorType = .activity
            productImageView.kf.setImage(with: URL(string: product.urlImagem),
                                         placeholder: UIImage(named: "question"))
            nameLabel.text = product.nome
            oldPriceLabel.text = "De: \(moneyFormatter(product.precoDe))"
            newPriceLabel.text =  "Por \(moneyFormatter(product.precoPor))"
            descriptionTextView.text = product.descricao.htmlToString
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = titleName
    }
    
    private func setupButton() {
        reserveButton.layer.cornerRadius = 5
        reserveButton.clipsToBounds = true
    }
    
    private func setupTextView() {
        descriptionTextView.textContainer.lineBreakMode = .byWordWrapping
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        descriptionTextView.textContainer.lineFragmentPadding = 0
    }

    @IBAction func reserveProduct(_ sender: Any) {
        Network.postReservarProduto(produtoId: produtoId) { _ in
            inMainAsync {
                let alert = UIAlertController(title: "Produto reservado com sucesso", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (alert) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true)
            }
        }
    }
    
}

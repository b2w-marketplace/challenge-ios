//
//  DetailViewController.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 28/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit
import SkeletonView

class DetailViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var productIndicator: UIActivityIndicatorView!
    @IBOutlet var skeletonViews: [UIView]!

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
        inMainAsync {
            self.loadProduct()
        }
    }
    
    private func loadProduct() {
        toggleSkeletonViews(visible: false)
        Network.getProdutoDetalhes(produtoId: produtoId) { [unowned self] (response) in
            dump(response)
            inMainAsync {
                self.product = response
                self.setupProductData()
                self.toggleSkeletonViews(visible: true)
            }
        }
    }
    
    private func toggleSkeletonViews(visible: Bool) {
        if !visible {
            nameLabel.numberOfLines = 2
            descriptionLabel.numberOfLines = 10
        } else {
            nameLabel.numberOfLines = 0
            descriptionLabel.numberOfLines = 0
        }
        
        skeletonViews.forEach { (view) in
            if !visible {
                view.showAnimatedSkeleton()
            } else {
                view.hideSkeleton()
            }
        }
    }

    private func showMessage(_ message: String, success: Bool) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (alert) in
            if success {
                self.navigationController?.popViewController(animated: true)
            }
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func reserveProduct(_ button: UIButton) {
        productIndicator.startAnimating()
        button.isUserInteractionEnabled = false
        
        Network.postReservarProduto(produtoId: produtoId, onCompletion: { (response) in
            inMainAsync {
                self.productIndicator.stopAnimating()
                button.isUserInteractionEnabled = true
                self.showMessage("Produto reservado com sucesso", success: true)
            }
        }) { _ in
             inMainAsync {
                self.productIndicator.stopAnimating()
                button.isUserInteractionEnabled = true
                self.showMessage("Erro ao reservar produto", success: false)
            }
        }
    }
    
}

//MARK: - Setups
extension DetailViewController {
    
    private func setupProductData() {
        if let product = self.product {
            productImageView.kf.indicatorType = .activity
            productImageView.kf.setImage(with: URL(string: product.urlImagem),
                                         placeholder: UIImage(named: "question"))
            nameLabel.text = product.nome
            let text = "De: \(moneyFormatter(product.precoDe))"
            oldPriceLabel.attributedText = text.withStrikethroughColor(.lightGray).withStrikethroughStyle(.single)
            newPriceLabel.text =  "Por \(moneyFormatter(product.precoPor))"
            descriptionLabel.text = product.descricao.htmlToString
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = titleName
    }
    
    private func setupButton() {
        reserveButton.layer.cornerRadius = 5
        reserveButton.clipsToBounds = true
    }
    
}

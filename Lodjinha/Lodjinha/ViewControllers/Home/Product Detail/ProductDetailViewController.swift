//
//  ProductDetailViewController.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 15/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import UIKit

class ProductDetailViewController: BaseViewController {
    
    //MARK: - Lets and Vars
    var product: Product? {
        didSet {
            self.title = product?.categoria.descricao
        }
    }
    let viewModel = ProductDetailViewModel()
    
    //MARK: - IBOutlets
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var newValue: UILabel!
    @IBOutlet weak var previousValue: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var reserveProductBtn: UIButton!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productName.text = (product?.nome)!
        self.previousValue.text = "De: " + (product?.precoDe.asLocaleCurrency)!
        self.newValue.text = "Por: " + (product?.precoPor.asLocaleCurrency)!
        self.productDescription.text = product?.descricao.html2String
        self.productImage.kf.setImage(with: URL(string: (product?.urlImagem)!))
    }

    //MARK: - IBActions
    @IBAction func reserveProductBtnClicked(_ sender: Any) {
        viewModel.reserveProduct(productID: "\((product?.id)!)", success: {
            self.showAlert(title: nil, message: "Produto reservado com sucesso.")
        }) { (error) in
            self.showAlert(title: "Erro", message: "Produto não encontrado.")
        }
    }
    
    //MARK: - Memory Management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

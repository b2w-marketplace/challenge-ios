//
//  ProductInfoViewController.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 12/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

class ProductInfoViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoIv: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var oldPriceLbl: UILabel!
    @IBOutlet weak var newPriceLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var reserveBtn: UIButton!
    
    let presenter = ProductInfoPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTexts()
        self.adjustLayouts()
    }
    
    private func setTexts() {
        self.photoIv.kf.setImage(with: self.presenter.photoUrl)
        self.nameLbl.text = self.presenter.productName
        self.oldPriceLbl.attributedText = self.presenter.oldPriceText
        self.newPriceLbl.text = self.presenter.newPriceString
        self.descriptionLbl.attributedText = self.presenter.productDescription
    }
    
    private func adjustLayouts() {
        self.reserveBtn.layer.cornerRadius = 10.0
        self.scrollView.contentInset.bottom = 100.0
    }
    
    @IBAction func reservePressed(_ sender: UIButton) {
    }
}

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
    @IBOutlet weak var loadingView: UIView!
    
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
        
        self.title = self.presenter.productName
        self.presenter.delegate = self
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
        self.presenter.reserveProduct()
    }
}

// MARK: - Presenter Delegate
extension ProductInfoViewController: ProductInfoPresenterDelegate {
    func setLoading(loading: Bool) {
        self.loadingView.isHidden = !loading
    }
    
    func showReserveAlert(reserved: Bool, message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            if reserved {
                self.navigationController?.popViewController(animated: true)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

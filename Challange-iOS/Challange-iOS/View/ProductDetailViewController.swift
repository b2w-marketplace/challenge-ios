//
//  ProductDetailViewController.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 21/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var bookButton: UIButton!
    
    var viewModel = ProductDetailViewModel()
    let disposeBag = DisposeBag()
    
    var productID = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        viewModel.getProduct(byID: productID)
        bindView()
    }
    
    func bindView() {
        
        viewModel.product.asObservable().bind { (value) in
            if let urlImage = value?.urlImagem {
                let url = URL(string: urlImage)
                let resource = ImageResource(downloadURL: url!)
                self.productImage.kf.setImage(with: resource)
            }
            self.productNameLabel.text = value?.nome ?? ""
            self.oldPriceLabel.text = value?.precoDe?.formatCurrency() ?? ""
            self.newPriceLabel.text = value?.precoPor?.formatCurrency() ?? ""
            self.descriptionTextView.text = value?.descricao?.htmlToString ?? ""
            self.navigationController?.navigationItem.title = value?.categoria?.descricao ?? ""
            
            }.disposed(by: disposeBag)
        
        bookButton.rx.tap
            .subscribe(onNext: { [unowned self] in
               self.viewModel.bookProduct(productID: self.productID)
            }).disposed(by: disposeBag)
        
        viewModel.resultMessage.asObservable()
            .bind { message in
                if !message.isEmpty {
                    self.presentMessage(message)
                }
            }.disposed(by: disposeBag)
        
        viewModel.isSuccess.asObservable()
            .bind { value in
                if value {
                    self.bookButton.isUserInteractionEnabled = false
                    self.bookButton.alpha = 0.7
                } else {
                    self.bookButton.isUserInteractionEnabled = true
                    self.bookButton.alpha = 1
                }
            }.disposed(by: disposeBag)
        
    }
    

}

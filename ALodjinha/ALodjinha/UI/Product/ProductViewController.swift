//
//  ProductViewController.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 27/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import PKHUD

class ProductViewController: UIViewController {
    
    var viewModel = ProductViewModel()
    let disposeBag = DisposeBag()

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceFromLabel: UILabel!
    @IBOutlet weak var priceToLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()
    }
    
    func setupRx() {
        
        viewModel.product.asObservable().subscribe(onNext: { [weak self] product in
            let url = URL(string: product.urlImage)
            self?.productImageView.kf.indicatorType = .activity
            self?.productImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder.jpg"))
            self?.productNameLabel.text = product.name
            let attributeString =  NSMutableAttributedString(string: String(format: "De: R$ %.2f", product.priceFrom))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            self?.priceFromLabel.attributedText = attributeString
            self?.priceToLabel.text = String(format: "Por: R$ %.2f", product.priceTo)
            self?.descriptionTextView.scrollsToTop = true
            self?.navigationItem.title = product.category.description
            
            do {
                let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                let str = try NSAttributedString(data: product.description.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: options, documentAttributes: nil)
                self?.descriptionTextView.attributedText = str
            } catch {
                self?.descriptionTextView.text = product.description
            }
            
        }).disposed(by: disposeBag)
        
        viewModel.response.asObservable().skip(1).subscribe(onNext: { response in
            
            HUD.hide()
            
            if response.success {
                
                let alert = UIAlertController(title: "Sucesso", message: "Produto reservado com sucesso", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                let alert = UIAlertController(title: "Erro", message: response.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }).disposed(by: disposeBag)
            
    }
    
    @IBAction func reserveAction(_ sender: Any) {
        HUD.show(.progress)
        viewModel.preOrderProduct()
    }
    
}

//
//  DetailProductViewController.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 14/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class DetailProductViewController: CustomViewController
{
    // MARK: - Lets and Vars
    var productID: Int!
    var detailProductViewModel: DetailProductViewModel?
    {
        didSet
        {
            detailProductViewModel?.productDidChange = { [weak self] viewModel in
                self?.setDetail()
            }
        }
    }
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var productDetailImage: UIImageView!
    @IBOutlet weak var productDetailNameLabel: UILabel!
    @IBOutlet weak var productDetailOldPrideLabel: UILabel!
    @IBOutlet weak var productDetailNewPriceLabel: UILabel!
    @IBOutlet weak var productDetailDescriptionLabel: UILabel!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        detailProductViewModel = DetailProductViewModel()
        getProduct()
    }

    
    private func getProduct()
    {
        let url = GenerateURL.get(type: .product) + String(productID)

        detailProductViewModel?.getElement(withURL: url, completion: { (error) in
            if let error = error
            {
                print("--> Error get product detail [VC]: \(error)")
                self.present(Alert.show(message: error.localizedDescription), animated: true, completion: nil)
            }
        })
    }
    
    private func setDetail()
    {
        let product = detailProductViewModel?.product
        let oldPrice = "De " + String(format: "%.2f", product?.priceOld ?? 0)
        let newPrice = "Por " + String(format: "%.2f", product?.priceNew ?? 0)
        
        productDetailImage.download(image: product?.image.urlImage ?? "")
        productDetailNameLabel.text = product?.name
        productDetailOldPrideLabel.attributedText = oldPrice.textMiddleLine()
        productDetailNewPriceLabel.text = newPrice
        productDetailDescriptionLabel.attributedText = product?.strDescription.html2AttributedString
    }
}

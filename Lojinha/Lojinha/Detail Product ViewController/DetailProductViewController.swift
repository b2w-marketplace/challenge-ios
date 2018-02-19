//
//  DetailProductViewController.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 14/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class DetailProductViewController: CustomViewController, VisibleView
{
    // MARK: - Lets and Vars
    var product: Product!
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
    @IBOutlet weak var productDetailScrollView: UIScrollView!
    @IBOutlet weak var productDetailImage: UIImageView!
    @IBOutlet weak var productDetailNameLabel: UILabel!
    @IBOutlet weak var productDetailOldPrideLabel: UILabel!
    @IBOutlet weak var productDetailNewPriceLabel: UILabel!
    @IBOutlet weak var productDetailDescriptionLabel: UILabel!
    @IBOutlet weak var productDetailBottomView: UIView!
    @IBOutlet weak var productDetailSetReverveButton: UIButton!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        Spinner.shared.show(view: self.view)
        
        self.set(title: product.name)
        configBtn()
        configNotificationCenter()
        
        detailProductViewModel = DetailProductViewModel()
        getProduct()
    }

    
    func isView(hide: Bool)
    {
        productDetailScrollView.isHidden = hide
        productDetailBottomView.isHidden = hide
        Spinner.shared.stopAnimating()
    }
    
    private func  configNotificationCenter()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(popViewController), name: popViewControllerNotificationCenter, object: nil)
    }
    
    private func configBtn()
    {
        productDetailSetReverveButton.cornerRadius(radius: Corner.button.rawValue)
    }
    
    // MARK: - Request
    private func getProduct()
    {
        let url = GenerateURL.get(type: .product) + String(product.id)

        detailProductViewModel?.getElement(withURL: url, completion: { (error) in
            if let error = error
            {
                print("--> Error get product detail [VC]: \(error)")
                self.isView(hide: true)
                self.present(Alert.show(message: error.localizedDescription), animated: true, completion: nil)
            }
        })
    }
    
    private func addReserve()
    {
        detailProductViewModel?.addProductToReserve(productID: product.id, completion: { (status, error) in
            if let status = status
            {
                self.isView(hide: false)
               self.showStatus(status: status)
            }
            if let error = error
            {
                print("--> Error add product to reserve [VC]: \(error)")
                self.isView(hide: true)
                self.present(Alert.show(message: error.localizedDescription), animated: true, completion: nil)
            }
        })
    }
    
    private func showStatus(status: StatusReserve)
    {
        let title = ""
        var message: String
        var isSucess: Bool = false
        
        if status.result == Status.success.rawValue
        {
            message = "Produto reservado com sucesso!"
            isSucess = true
        }
        else if status.result == Status.error.rawValue
        {
            message = "Producto não encontrado..."
        }
        else
        {
            message = "Não foi possível reservar o produto no momento..."
        }
        
        self.present(Alert.show(title: title, message: message, isSuccess: isSucess), animated: true, completion: nil)
    }
    
    // MARK: - Set View Elements
    private func setDetail()
    {
        let product = detailProductViewModel?.product
        
        productDetailImage.download(image: product?.image.urlImage ?? "")
        productDetailNameLabel.text = product?.name
        productDetailOldPrideLabel.attributedText = product?.priceOld.oldPrice
        productDetailNewPriceLabel.text = product?.priceNew.newPrice
        productDetailDescriptionLabel.attributedText = product?.strDescription.html2AttributedString
        
        isView(hide: false)
    }
    
    // MARK: - Pop View Controller
    @objc func popViewController()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - IBAction
    @IBAction func addToReserve(_ sender: UIButton)
    {
        Spinner.shared.show(view: self.view)
        addReserve()
    }
    
}

//
//  ProductDetailViewController.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import UIKit
import RxSwift

class ProductDetailViewController: BaseViewController {
    
    @IBOutlet weak var imageProduct: AlamofireImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelOriginalPrice: UILabel!
    @IBOutlet weak var labelCurrentPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    @IBOutlet weak var btnReserve: UIButton!
    
    var productId: Int!
    
    var reserveManager: ProductReserveManager!
    var client: APIClient!
    
    private var product: Variable<ProductModel?> = Variable(nil)
    
    private var disposeBag = DisposeBag()
    
    class func instantiate() -> ProductDetailViewController {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "productDetail") as! ProductDetailViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.ReservationConfirmed, object: nil, queue: nil) { [weak self] (not) in
            if let s = self,
                let productId = not.userInfo?["productId"] as? Int,
                productId == s.productId
            {
                s.btnReserve.isEnabled = true
                s.reserveManager.reservationConfirmed(s.productId)
                let alert = UIAlertController.init(title: "Sua reserva foi concluída com sucesso!", message: "Agora é só continuar navegando :)", preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (a) in
                    s.navigationController?.popViewController(animated: true)
                }))
                s.present(alert, animated: true, completion: nil)
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.ReservationError, object: nil, queue: nil) { [weak self] (not) in
            if let s = self,
                let dict = not.userInfo,
                let productId = dict["productId"] as? Int,
                productId == s.productId
            {
                s.btnReserve.isEnabled = true
                s.displayAlertWithMessage("Ocorreu um erro ao realizar sua reserva.", body: "Verifique sua conexão e tente novamente.")
            }
        }
        
        btnReserve.isEnabled = !reserveManager.isReserving(productId)
        
        setLoadingCover()
        
        loadingView.setCallback { [weak self] in
            self?.loadProductDetail()
        }
        
        loadProductDetail()
        
        bindView()
    }
    
    private func loadProductDetail() {
        client.lodjinhaProvider.moyaRequest(.getProductForId(productId: productId), type: ProductModel.self).subscribe(onNext: { [weak self] (product) in
            if let s = self {
                s.loadingView.hide()
                s.product.value = product
            }
        }, onError: { [weak self] (error) in
            if let s = self {
                s.loadingView.displayError()
            }
        }).disposed(by: disposeBag)
    }
    
    private func bindView() {
        product.asObservable().subscribe(onNext: { [weak self] (product) in
            if let p = product, let s = self {
                s.title = p.name
                
                s.imageProduct.loadImageFor(url: p.imgUrl, placeholderImg: nil)
                s.labelProductName.text = p.name
                
                if p.discountPrice != nil {
                    s.labelOriginalPrice.attributedText = p.formattedAttributedOriginalPrice()
                    s.labelCurrentPrice.text = p.formattedDiscountPrice()
                } else {
                    s.labelOriginalPrice.text = ""
                    s.labelCurrentPrice.text = p.formattedOriginalPrice()
                }
                
                if let attString = p.description.convertHtml() {
                    s.labelDescription.attributedText = attString
                } else {
                    s.labelDescription.text = p.description
                }
            }
        }).disposed(by: disposeBag)
    }
    
    @IBAction func reserve() {
        btnReserve.isEnabled = false
        reserveManager.reserveProduct(productId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

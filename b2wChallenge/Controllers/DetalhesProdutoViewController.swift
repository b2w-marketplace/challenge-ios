//
//  DetalhesProdutoViewController.swift
//  b2wChallenge
//
//  Created by Felipe Mac on 11/5/18.
//  Copyright © 2018 Felipe Mac. All rights reserved.
//

import UIKit
import Alamofire

class DetalhesProdutoViewController: UIViewController {
    
    var arrayProduto : [[String:AnyObject]] = []
    var objectProduto : DataMaisVendidos?
    
    @IBOutlet weak var produtoImageView: UIImageView!
    @IBOutlet weak var produtoNomeBotton: UILabel!
    @IBOutlet weak var oldValue: UILabel!
    @IBOutlet weak var newValue: UILabel!
    @IBOutlet weak var descriptionProduto: UITextView!
    @IBOutlet weak var reservarButton: UIButton!
    
    var selectedProduct: DataMaisVendidos?
    
    override func viewWillDisappear(_ animated: Bool) {

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let descriptionCategory = selectedProduct?.categoria?.descricao {
            Utils.formatNavigationTitleFontWithDefaultStyle(view: self, description: descriptionCategory)
        }
        
        reservarButton.layer.cornerRadius = 5
        DispatchQueue.main.async {
            self.getDetalheProduto()
        }
    }

    func displayData() {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        if let nomeProduto = objectProduto?.nome {
            produtoNomeBotton.text = nomeProduto
        }
        
        if let productOldValue = objectProduto?.precoDe {
            
            if let formattedTipAmount = formatter.string(from: productOldValue as NSNumber) {
                oldValue.text = "De \(formattedTipAmount)"
            }
            let attributeString =  NSMutableAttributedString(string: "\(oldValue.text ?? "De")")
            
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                         value: NSUnderlineStyle.styleSingle.rawValue,
                                         range: NSMakeRange(0, attributeString.length))
            self.oldValue.attributedText = attributeString
        }
        
        if let productoNewValue = objectProduto?.precoPor {
            if let formattedTipAmount = formatter.string(from: productoNewValue as NSNumber) {
                newValue.text = "Por \(formattedTipAmount)"
            }
        }
        
        if let descricaoProduto = objectProduto?.descricao {

            let data = descricaoProduto.data(using: String.Encoding.unicode)!
            let attrStr = try? NSAttributedString(
                data: data,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            descriptionProduto.attributedText = attrStr
        }
        
        if let imageProduto = objectProduto?.urlImagem {
                self.produtoImageView.image = nil
                
                if let imageFromCache = Utils.imageCache.object(forKey: imageProduto as AnyObject) as? UIImage {
                    self.produtoImageView.image = imageFromCache
                } else {
                    if let url = URL(string: imageProduto) {
                        if let data = try? Data(contentsOf: url) {
                            if let imageToCache = UIImage(data: data) {
                                self.produtoImageView.image = imageToCache
                                Utils.imageCache.setObject(imageToCache, forKey: imageProduto as AnyObject)
                            }
                        }
                    }
                }
            }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ReservarPedido(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.postRealizarPedido()
        }
    }
    
    func confirmacaoPedido() {
        
        let alert = UIAlertController(title: "Confirmaçao de Pedido", message: "Seu Pedido foi realizado com sucesso", preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            self.navigationController?.popViewController(animated: true)

        }
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Api's
    func getDetalheProduto() {
        
        Utils.setLoadingScreen(view: self.view)
        
        var id = Int()
        
        if let produtctID = selectedProduct?.id {
            id = produtctID
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        
        manager.request("https://alodjinha.herokuapp.com/produto/\(id)", method: .get).responseJSON { response in
            
            switch (response.result) {
            case .success:
                
                if let jsonDict = response.result.value as? [String:AnyObject] {
                    
                     let produto = DataMaisVendidos(dictionary: jsonDict)
                     self.objectProduto = produto
                    
                    self.displayData()
                    Utils.removeLoadingScreen(view: self.view)
                }
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func postRealizarPedido() {
        
        Utils.setLoadingScreen(view: self.view)
        
        var id = Int()
        
        if let produtctID = selectedProduct?.id {
            id = produtctID
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        
        manager.request("https://alodjinha.herokuapp.com/produto/\(id)", method: .post).responseJSON { response in
            
            switch (response.result) {
            case .success:
                
                if let jsonDict = response.result.value as? [String:AnyObject] {
                    
                    if let result = jsonDict["result"] as? String {
                        
                        if result == "success" {
                             self.confirmacaoPedido()
                        }else{
                            let alert = UIAlertController(title: "Confirmaçao de Pedido", message: "Seu Pedido não pode ser completado, por favor tente novamente", preferredStyle: UIAlertControllerStyle.alert)
                            
                            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                
                                Utils.removeLoadingScreen(view: self.view)
                                
                            }
                            alert.addAction(OKAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

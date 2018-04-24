//
//  DetalheProdutoViewController.swift
//  Lodginha
//
//  Created by Ricardo Bailoni on 23/04/2018.
//  Copyright © 2018 Ricardo Bailoni. All rights reserved.
//

import UIKit
import WebKit

class DetalheProdutoViewController: UIViewController {
    @IBOutlet weak var ivProduto: CustomImageView!
    @IBOutlet weak var lbNomeProduto: UILabel!
    @IBOutlet weak var lbPrecoDe: UILabel!
    @IBOutlet weak var lbPrecoPor: UILabel!
    @IBOutlet weak var btReservar: UIButton!
    @IBOutlet weak var tvDescricaoProduto: UITextView!
    
    var produto: Produto?
    
    lazy var produtoManager: ProdutoManager = {
        return ProdutoManager()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = produto?.categoria.descricao
        self.tabBarController?.tabBar.isHidden = true
        produtoManager.delegate = self
        
        guard let produto = produto else {
            return
        }
        
        let attrPrecoDe: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.strikethroughStyle: 1,
            NSAttributedStringKey.strikethroughColor: UIColor(red: 186/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0)
        ]
        
        ivProduto.loadImageWithStringURL(stringURL: produto.urlImagem)
        lbNomeProduto.text = produto.nome
        lbPrecoDe.attributedText = NSAttributedString(string: produto.precoDe.formatNumber(prefix: "De: "), attributes: attrPrecoDe)
        lbPrecoPor.text = produto.precoPor.formatNumber(prefix: "Por ")
        tvDescricaoProduto.attributedText = produto.descricao.html
        tvDescricaoProduto.font = UIFont.systemFont(ofSize: 17.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBAction func efetuaReserva(_ sender: UIButton) {
        if let produto = produto {
            sender.isHidden = true
            produtoManager.sendProdutoReserva(id: produto.id)
        }
    }
}

extension DetalheProdutoViewController: ProdutoManagerDelegate {
    func finishLoadProdutos(manager: ProdutoManager, result: ProdutosResult) {
        let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.btReservar.isHidden = false
        }
        
        guard result.error == nil else {
            DispatchQueue.main.async {
                let alert = CustomAlert.loadAlert(type: .error, message: result.error!, actions: [actionOk])
                self.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        DispatchQueue.main.async {
            let alert = CustomAlert.loadAlert(type: .success, message: result.result!, actions: [actionOk])
            self.present(alert, animated: true, completion: nil)
        }
    }
}

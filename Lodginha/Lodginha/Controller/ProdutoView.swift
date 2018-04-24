//
//  ProdutoView.swift
//  Lodginha
//
//  Created by Ricardo Bailoni on 22/04/2018.
//  Copyright © 2018 Ricardo Bailoni. All rights reserved.
//

import UIKit

class ProdutoView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var ivProduto: CustomImageView!
    @IBOutlet weak var lbNomeProduto: UILabel!
    @IBOutlet weak var lbPrecoDe: UILabel!
    @IBOutlet weak var lbPrecoPor: UILabel!
    
    let numberFormatter = NumberFormatter()
    
    var produto: Produto? {
        didSet {
            guard let produto = produto else {
                lbNomeProduto.text = nil
                lbPrecoDe.text = nil
                lbPrecoPor.text = nil
                ivProduto.image = nil
                return
            }
            let attr: [NSAttributedStringKey: Any] = [
                NSAttributedStringKey.strikethroughStyle: 1,
                NSAttributedStringKey.strikethroughColor: UIColor(red: 186/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0)
            ]
            lbNomeProduto.text = produto.nome
            lbPrecoDe.attributedText = NSAttributedString(string: formatNumber(value: produto.precoDe, prefix: "De: "), attributes: attr)
            lbPrecoPor.text = formatNumber(value: produto.precoPor, prefix: "Por ")
            ivProduto.loadImageWithStringURL(stringURL: produto.urlImagem)
        }
    }
    
    func formatNumber(value: Double, prefix: String?) -> String {
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = prefix ?? ""
        numberFormatter.alwaysShowsDecimalSeparator = true
        
        return numberFormatter.string(for: value) ?? "0"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ProdutoView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

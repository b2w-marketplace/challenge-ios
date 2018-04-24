//
//  CategoriaView.swift
//  Lodginha
//
//  Created by Ricardo Bailoni on 22/04/2018.
//  Copyright © 2018 Ricardo Bailoni. All rights reserved.
//

import UIKit

class CategoriaView: UIView {
    @IBOutlet weak var ivCategoria: CustomImageView!
    @IBOutlet weak var lbCategoria: UILabel!
    @IBOutlet weak var btCategoria: UIButton!
    
    var categoria: Categoria? {
        didSet {
            if let categoria = categoria {
                ivCategoria.loadImageWithStringURL(stringURL: categoria.urlImagem)
                lbCategoria.text = categoria.descricao
            }
        }
    }
}

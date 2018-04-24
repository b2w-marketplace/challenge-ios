//
//  CategoriaManager.swift
//  Lodginha
//
//  Created by Ricardo Bailoni on 22/04/2018.
//  Copyright © 2018 Ricardo Bailoni. All rights reserved.
//

import Foundation

protocol CategoriaManagerDelegate {
    func finishLoadCategorias(manager: CategoriaManager, result: CategoriasResult)
}

class CategoriaManager {
    lazy var categoriaSinc: CategoriaSinc = {
        return CategoriaSinc()
    }()
    var delegate: CategoriaManagerDelegate?
    
    func showCategorias() {
        categoriaSinc.delegate = self
        categoriaSinc.getCategorias()
    }
}

extension CategoriaManager: CategoriaSincDelegate {
    func finishRequestCategoria(categoriaSinc: CategoriaSinc, result: CategoriasResult) {
        delegate?.finishLoadCategorias(manager: self, result: result)
    }
}

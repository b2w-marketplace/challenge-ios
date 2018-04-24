//
//  ProdutoManager.swift
//  Lodginha
//
//  Created by Ricardo Bailoni on 22/04/2018.
//  Copyright © 2018 Ricardo Bailoni. All rights reserved.
//

import Foundation

protocol ProdutoManagerDelegate {
    func finishLoadProdutos(manager: ProdutoManager, result: ProdutosResult)
}

class ProdutoManager {
    lazy var produtoSinc: ProdutoSinc = {
        return ProdutoSinc()
    }()
    var delegate: ProdutoManagerDelegate?
    
    func showProdutosMaisVendidos() {
        produtoSinc.delegate = self
        produtoSinc.getProdutosMaisVendidos()
    }
    
    func showProdutosCategoria(id: Int) {
        produtoSinc.delegate = self
        produtoSinc.getProdutos(categoriaID: id)
    }
    
    func sendProdutoReserva(id: Int) {
        produtoSinc.delegate = self
        produtoSinc.postReservaProduto(produtoID: id)
    }
}

extension ProdutoManager: ProdutoSincDelegate {
    func finishRequestProduto(produtoSinc: ProdutoSinc, result: ProdutosResult) {
        delegate?.finishLoadProdutos(manager: self, result: result)
    }
}

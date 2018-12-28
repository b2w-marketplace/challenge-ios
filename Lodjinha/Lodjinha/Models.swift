//
//  Models.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 28/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

//MARK: - Banner
public struct Banner: Decodable {
    var id: Int
    var linkUrl: String
    var urlImagem: String
}

public struct BannerResponse: Decodable {
    var data: [Banner]
}

//MARK: - Categoria
public struct Categoria: Decodable {
    var id: Int
    var descricao: String
    var urlImagem: String
}

public struct CategoriaResponse: Decodable {
    var data: [Categoria]
}

//MARK: - Produto
public struct Produto: Decodable {
    var categoria: Categoria
    var id: Int
    var descricao: String
    var nome: String
    var precoDe: Double
    var precoPor: Double
    var urlImagem: String
}

public struct ProdutoResponse: Decodable {
    var data: [Produto]
    var offset: Int?
    var total: Int?
}



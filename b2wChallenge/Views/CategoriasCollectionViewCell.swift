//
//  CategoriasCollectionViewCell.swift
//  b2wChallenge
//
//  Created by Felipe Mac on 10/5/18.
//  Copyright © 2018 Felipe Mac. All rights reserved.
//

import UIKit

class CategoriasCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoriaImage: UIImageView!
    @IBOutlet weak var categoriaDescription: UILabel!
    
    var categoria: DataCategoria? {
        didSet {
            
            if let data = categoria {
                
                if let descricao = data.descricao {
                    categoriaDescription.text = descricao
                }
                
                if let urlImage = data.urlImagem {
                    self.categoriaImage.image = nil
                    
                    if let imageFromCache = Utils.imageCache.object(forKey: urlImage as AnyObject) as? UIImage {
                        categoriaImage.image = imageFromCache
                    } else {
                        categoriaImage.image = #imageLiteral(resourceName: "empty")
                    }
                }
            }
        }
    }
}


//
//  CategoryCollectionViewCell.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices

class CategoryViewModel{
    var url :URL
    var description:String
    var id:Int
    
    init(model:Categoria) {
        self.id = model.id
        if !model.urlImagem.contains("https:"){
            let urlFormatada = model.urlImagem.replacingOccurrences(of: "http", with: "https")
            self.url = URL(string: urlFormatada)!

        }else{
            self.url = URL(string: model.urlImagem)!

        }

        
        
        self.description = model.descricao
    }
    
}
class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageCategory: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func register(to collectionView:UICollectionView) {
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
    func setup(viewModel:CategoryViewModel){
        let scale = UIScreen.main.scale
        self.descriptionLabel.text = viewModel.description
        
        let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: self.frame.width * scale, height: 76 * scale))
        imageCategory.kf.indicatorType = .activity
        
        imageCategory.kf.setImage(with: viewModel.url,placeholder:#imageLiteral(resourceName: "placeholder"),
                                  options: [.processor(resizingProcessor)],
                                  completionHandler: nil)
        
    }
}

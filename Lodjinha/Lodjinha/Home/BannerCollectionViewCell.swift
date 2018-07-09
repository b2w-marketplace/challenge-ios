//
//  BannerCollectionViewCell.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices

class BannerViewModel{
    var url :URL
    var link: String
    
    init(model:Banner) {
        
        self.url = URL(string: model.urlImagem)!
        self.link = model.linkUrl
    }
    
}
class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageBanner: UIImageView!
    var viewModel : BannerViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func register(to collectionView:UICollectionView) {
        let nib = UINib(nibName: "BannerCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BannerCollectionViewCell")
    }
    
    func setup(viewModel:BannerViewModel){
        self.viewModel = viewModel
        let scale = UIScreen.main.scale
        

        let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: self.frame.width * scale, height: 127.0 * scale))
        imageBanner.kf.indicatorType = .activity
        imageBanner.kf.setImage(with: viewModel.url,
                              options: [.processor(resizingProcessor)],
                              completionHandler: { [ weak self] image, error, cacheType, imageURL in
                                self?.imageBanner.layer.shadowOpacity = 0.5
            })

    }
}

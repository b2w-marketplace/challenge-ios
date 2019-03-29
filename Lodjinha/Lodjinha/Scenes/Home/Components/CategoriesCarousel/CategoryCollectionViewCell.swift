//
//  CategoryCollectionViewCell.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    let cellImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellBackgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(cellImage)
        cellBackgroundView.addSubview(cellLabel)
        
        backgroundColor = .clear
        setupViews()
    }
    
    func setupViews() {
        
        //cellbackgroundView
        cellBackgroundView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        cellBackgroundView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        cellBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cellBackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        //cellImage
        cellImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: cellLabel.topAnchor, constant: -4).isActive = true
        cellImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cellImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // cellLabel
        cellLabel.leftAnchor.constraint(equalTo: cellBackgroundView.leftAnchor, constant: 8).isActive = true
        cellLabel.rightAnchor.constraint(equalTo: cellBackgroundView.rightAnchor, constant: -8).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -8).isActive = true
    }
    
    func configure(with category: ProductCategory) {
        cellImage.setImage(fromUrl: category.imageUrl, withIndicator: nil, defaultImage: UIImage(named: "downloadImageDefault"))
        cellLabel.text = category.description
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.image = nil
        cellLabel.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  CategoriesTableViewCell.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 06/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var category: [Category]?
    weak var delegate: CategoriesViewDelegate?
    weak var homeViewDelegate: HomeViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCell()
    }
    
    private func registerCell() {
        let categoriesNibName = UINib(nibName: CategorriesString.CategoriesCollectionViewCell, bundle: nil)
        collectionView.register(categoriesNibName, forCellWithReuseIdentifier: CategorriesString.CategoriesCollectionCell)
    }
    
    private func hideLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }

}

extension CategoriesTableViewCell: CategoriesViewDelegate {
    func fetchCategory(category: [Category]) {
        DispatchQueue.main.async {
            self.category = category
            self.collectionView.reloadData()
        }
    }
}

extension CategoriesTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorriesString.CategoriesCollectionCell, for: indexPath) as? CategoriesCollectionViewCell else {
            return CategoriesCollectionViewCell()
        }
        cell.fill(dto: CategoriesCellDTO(image: category?[indexPath.row].urlImagem ?? "",
                                         description: category?[indexPath.row].descricao ?? ""))
        hideLoading()
        return cell
    }
}

extension CategoriesTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeViewDelegate?.displayProduct(category: category?[indexPath.row] ?? Category(descricao: "",
                                                                                        id: 0,
                                                                                        urlImagem: ""))
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width/4, height: self.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

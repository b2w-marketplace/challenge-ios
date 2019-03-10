//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 10/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    let presenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationTitle()
        self.presenter.delegate = self
        
    }
    
    private func setNavigationTitle() {
        let titleImage = UIImage(named: "nav_title")
        let titleIv = UIImageView(image: titleImage)
        self.navigationItem.titleView = titleIv
    }
    
    private func configCategoriesCollection() {
        if let flowLayout = self.categoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 100, height: 80)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Presenter Delegate
extension HomeViewController: HomePresenterDelegate {
    func reloadCategories() {
        self.categoriesCollectionView.reloadData()
    }
}

// MARK: - Categories
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.numberOfCategories
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionCell
        let categoryInfo = self.presenter.categoryInfo(atIndex: indexPath)
        
        cell.categoryIv.kf.setImage(with: categoryInfo.image)
        cell.nameLbl.text = categoryInfo.name
        
        return cell
    }
}

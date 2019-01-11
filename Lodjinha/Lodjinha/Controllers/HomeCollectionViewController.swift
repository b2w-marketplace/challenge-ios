//
//  HomeCollectionViewController.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        title = Constants.Home

        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logoNavbar").resized(nil, 38))

//        NetworkService(withBaseURL: Constants.BaseUrl).fetch(fromRoute: Routes.ProductById, productId: 2) {[weak self] (result) in
//            guard let `self` = self else { return }
//            if let product = result.value {
//                let viewModel = ProductInfoViewModel(product: product)
//                self.performSegue(withIdentifier: "ProductInfoSegue", sender: viewModel)
//            }
//        }
    }

    @IBAction func go(_ sender: Any) {
        self.performSegue(withIdentifier: "ProductListSegue", sender: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "ProductInfoSegue" {
            if let viewController = segue.destination as? ProductInfoViewController,
                let productViewModel = sender as? ProductInfoViewModel {
                viewController.productInfoViewModel = productViewModel
                viewController.hidesBottomBarWhenPushed = true
            }
        } else if segue.identifier == "ProductListSegue" {
            if let viewController = segue.destination as? ProductListViewController,
                let categoryId = sender as? Int {
                viewController.categoryId = categoryId
                viewController.hidesBottomBarWhenPushed = true
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        // Configure the cell

        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

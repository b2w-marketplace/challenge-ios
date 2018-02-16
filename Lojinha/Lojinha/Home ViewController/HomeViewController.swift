//
//  HomeViewController.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class HomeViewController: CustomViewController
{
    // MARK: - Lets and Vars
    var listBannerViewModel: BannerViewModel?
    {
        didSet
        {
            listBannerViewModel?.listBannerDidChange = { [weak self] viewModel in
                self?.homeTableView.reloadData()
            }
        }
    }
    
    var listCategoryViewModel: CategoryViewModel?
    {
        didSet
        {
            listCategoryViewModel?.listCategoryDidChange = { [weak self] viewModel in
                self?.homeTableView.reloadData()
            }
        }
    }
    
    var listTopSellingProducts: TopSellingProductsViewModel?
    {
        didSet
        {
            listTopSellingProducts?.listTopSellingProductsDidChange = { [weak self] viewModel in
                self?.homeTableView.reloadData()
            }
        }
    }
    

    // MARK: - IBOutlets
    @IBOutlet weak var homeTableView: UITableView!
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

//        self.setTitleWithCustomFont(title: "a Lojinha")

        listBannerViewModel = BannerViewModel()
        listCategoryViewModel = CategoryViewModel()
        listTopSellingProducts = TopSellingProductsViewModel()
        
        getBanners()
        getCategories()
        getTopSellingProducts()
        
        homeTableView.tableFooterView = UIView()
    }
    
    private func getBanners()
    {
        listBannerViewModel?.getElement(completion: { (error) in
            if let error = error
            {
                print("-->> Error get banners [VC]: \(error)")
                self.present(Alert.show(message: error.localizedDescription), animated: true, completion: nil)
            }
        })
    }
    
    private func getCategories()
    {
        listCategoryViewModel?.getElement(completion: { (error) in
            if let error = error
            {
                print("-->> Error get categories [VC]: \(error)")
                self.present(Alert.show(message: error.localizedDescription), animated: true, completion: nil)
            }
        })
    }
    
    private func getTopSellingProducts()
    {
        listTopSellingProducts?.getElement(completion: { (error) in
            if let error = error
            {
                print("-->> Error get top selling products [VC]: \(error)")
                self.present(Alert.show(message: error.localizedDescription), animated: true, completion: nil)
            }
        })
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == Segue.detailProduct.rawValue
        {
            let productDetail = segue.destination as! DetailProductViewController
            productDetail.productID = (sender as! Product).id
        }
        
        if segue.identifier == Segue.detailCategory.rawValue
        {
            let productsByCategory = segue.destination as! CategoryListDetailViewController
            productsByCategory.categoryID = (sender as! Category).id
        }
        
    }
}


extension HomeViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 || section == 1
        {
            return 1
        }
        
        return listTopSellingProducts?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 1
        {
            return "Categorias"
        }
        if section == 2
        {
            return "Mais vendidos"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let row = indexPath.row
        let section = indexPath.section
        
        var cell: UITableViewCell
        if section == 0
        {
            cell = homeTableView.dequeueReusableCell(withIdentifier: CellIdentifier.bannerHome.rawValue, for: indexPath) as! BannerHomeTableViewCell
        }
        else if section == 1
        {
            cell = homeTableView.dequeueReusableCell(withIdentifier: CellIdentifier.listCatetoryHome.rawValue, for: indexPath) as! CategoryHomeTableViewCell
        }
        else
        {
            cell = homeTableView.dequeueReusableCell(withIdentifier: CellIdentifier.listHome.rawValue, for: indexPath) as! ProductTableViewCell
            
            let product = listTopSellingProducts?.list?.products[row]
            (cell as! ProductTableViewCell).product = product
        }
        
        
        return cell
    }
}


extension HomeViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let section = indexPath.section
        if section == 0
        {
            return 100
        }
        if section == 1
        {
            return 100
        }
        return UITableViewAutomaticDimension
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        let viewHeader = UIView()
//        viewHeader.backgroundColor = UIColor.white
//
//        return viewHeader
//    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let row = indexPath.row
        let section = indexPath.section
        
        if section == 0
        {
            guard let bannerTbCell = cell as? BannerHomeTableViewCell else { return }
            bannerTbCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: row)
        }
        if section == 1
        {
            guard let categoryTbCell = cell as? CategoryHomeTableViewCell else { return }
            categoryTbCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        homeTableView.deselectRow(at: indexPath, animated: true)
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 2
        {
            let product = listTopSellingProducts?.list?.products[row]
            self.performSegue(withIdentifier: Segue.detailProduct.rawValue, sender: product)
        }
    }
}


extension HomeViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView.restorationIdentifier == RestorationID.bannerHome.rawValue
        {
            return listBannerViewModel?.numberOfRows() ?? 0
        }
        
        return listCategoryViewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let item = indexPath.item
        var cell: UICollectionViewCell
        
        if collectionView.restorationIdentifier == RestorationID.bannerHome.rawValue
        {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.bannerCell.rawValue, for: indexPath) as! BannerCollectionViewCell
            
            let banner = listBannerViewModel?.list?.banners[item]
            (cell as! BannerCollectionViewCell).banner = banner
        }
        else
        {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.categoryCell.rawValue, for: indexPath) as! CategoryCollectionViewCell
        
            let category = listCategoryViewModel?.list?.categories[item]
            (cell as! CategoryCollectionViewCell).category = category
        }
        
        return cell
    }
}


extension HomeViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView.restorationIdentifier == RestorationID.bannerHome.rawValue
        {
            
        }
        else
        {
            let item = indexPath.item
            let category = listCategoryViewModel?.list?.categories[item]
            self.performSegue(withIdentifier: Segue.detailCategory.rawValue, sender: category)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var width = collectionView.frame.width
        var height = collectionView.frame.height
        
        if collectionView.restorationIdentifier == RestorationID.bannerHome.rawValue
        {
            height = width * (241/374)
        }
        
        else
        {
            width = width / 4
//            height = height - 10
        }
        
        return CGSize(width: width, height: height)
    }
}

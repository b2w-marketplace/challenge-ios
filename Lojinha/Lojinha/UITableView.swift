//
//  TableView.swift
//  Lojinha
//
//  Created by Rodrigo A E Miyashiro on 11/02/17.
//  Copyright © 2017 Rodrigo Miyashiro. All rights reserved.
//

import UIKit


// MARK: - TableView DataSource
// MARK: Extension HomeViewController
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
        return self.productsBestSellers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let section = indexPath.section
        
        if section == 0
        {
            return CGFloat(CellHeight.bannerCell.rawValue)
        }
        return CGFloat(CellHeight.bannerCell.rawValue)
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
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor().dark()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let section = indexPath.section
        
        var CellIdentifier: String
        var cell: UITableViewCell
        
        if section == 0
        {
            CellIdentifier = "cellBanner"
            cell = homeTableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! BannerTableViewCell
            
            (cell as! BannerTableViewCell).scrollViewToBanner.delegate = self
            self.configBanner(cell: cell as! BannerTableViewCell, banners: self.banners)
        }
        else if section == 1
        {
            CellIdentifier = "cellCollectionView"
            cell = homeTableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! CollectionCategoriesTableViewCell
            
            (cell as! CollectionCategoriesTableViewCell).setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        }
        else
        {
            CellIdentifier = "cellBestSellers"
            cell = homeTableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) //as! ProductTableViewCell
            
            let row = indexPath.row
            let productBS = self.productsBestSellers[row]
            
            (cell as! ProductTableViewCell).lblProductName.text = productBS.name
            (cell as! ProductTableViewCell).lblProductOldPrice.attributedText = self.strikethrough(str: "De: \(productBS.oldPrice)")
            (cell as! ProductTableViewCell).lblProductPromotionalPrice.text = "Por \(productBS.promotionalPrice)"

            Request.getImage(url: productBS.urlImage, completion: { (dataImg) in
                (cell as! ProductTableViewCell).imgProduct.image = UIImage(data: dataImg)
            })
            
        }
        
        return cell
    }
    
    
    // MARK: Config Banner
    func configBanner(cell: BannerTableViewCell, banners: [Banner]) {
        let scrollViewHeight = cell.scrollViewToBanner.frame.height
        let scrollViewWidth = cell.scrollViewToBanner.frame.width
        
        for position in 0..<banners.count {
            let img = UIImageView(frame: CGRect(x: (scrollViewWidth * CGFloat(position)), y: 0, width: scrollViewWidth, height: scrollViewHeight))
            
            let imgBannerURL = banners[position].urlImage
            
            Request.getImage(url: imgBannerURL, completion: { (data) in
                img.image = UIImage(data: data)
                cell.scrollViewToBanner.addSubview(img)
            })
        }
        
        cell.scrollViewToBanner.contentSize = CGSize(width: cell.scrollViewToBanner.frame.width * CGFloat(banners.count), height: cell.scrollViewToBanner.frame.height)
    }
    
    func strikethrough(str: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: str)
        attributedString.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor().greyish(), range: NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
}


// MARK: Extension Items of a category
extension ItemsOfACategoryViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "ItemsCategoryCell"
        let cell = self.categoryTableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! ProductTableViewCell
        
        
        return cell
    }
}


// MARK: - TableView Delegate
// MARK: Extension HomeViewController
extension HomeViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.homeTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Extension Items of a category
extension ItemsOfACategoryViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.categoryTableView.deselectRow(at: indexPath, animated: true)
    }
}

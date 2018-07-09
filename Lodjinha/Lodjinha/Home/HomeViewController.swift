//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bestSellerTableView: UITableView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    private var collectionBannerDataSource:CollectionViewDataSource<BannerCollectionViewCell, BannerViewModel>!
    private var collectionCategoryDataSource:CollectionViewDataSource<CategoryCollectionViewCell, CategoryViewModel>!
    
    private var tableViewBestSellerDataSource:TableViewDataSource<BestSellerTableViewCell, BestSellerViewModel>!


    var homeViewModel = HomeViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navController = navigationController!
        
        let image = UIImage(named: "logoNavbar_1") //Your logo url here
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
        
       
        pageControl.hidesForSinglePage = true
        BestSellerTableViewCell.register(to: bestSellerTableView)

   
       // BannerCollectionViewCell.register(to: bannerCollectionView)

        homeViewModel.loadBanners {
            self.setupBannerCollectionView()
        }
        
        homeViewModel.loadCategories {
            self.setupCategoryCollectionView()
        }
        
        homeViewModel.loadBestSellers {
            self.setupBestSellerView()
        }
        // Do any additional setup after loading the view.
    }
    
    func setupBestSellerView(){
        self.tableViewBestSellerDataSource = TableViewDataSource(cellIdentifier: "BestSellerTableViewCell", items: self.homeViewModel.listBestSellerItems, configureCell: { (cell, viewModel) in
            
            cell.setup(viewModel: viewModel)
        })
        self.bestSellerTableView.delegate = self
        self.bestSellerTableView.dataSource = tableViewBestSellerDataSource
        DispatchQueue.main.async {
            self.bestSellerTableView.reloadData()
        }
    }
    
    func setupCategoryCollectionView(){
        self.collectionCategoryDataSource = CollectionViewDataSource(cellIdentifier: "CategoryCollectionViewCell", items: self.homeViewModel.listCategoryOfItems, configureCell: { (cell, viewModel) in
            
            cell.setup(viewModel: viewModel)
        })
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = collectionCategoryDataSource
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
        }
    }
    
    func setupBannerCollectionView(){
        self.collectionBannerDataSource = CollectionViewDataSource(cellIdentifier: "BannerCollectionViewCell", items: self.homeViewModel.listBannerOfItems, configureCell: { (cell, viewModel) in
            
            cell.setup(viewModel: viewModel)
        })
        self.bannerCollectionView.delegate = self
        self.bannerCollectionView.dataSource = collectionBannerDataSource
        DispatchQueue.main.async {
            self.bannerCollectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColumns: CGFloat = 0
        if collectionView == bannerCollectionView{
            numberOfColumns = 1
        }else{
            numberOfColumns = 4
        }
        
        
        let spaceBetweenCells:CGFloat = 20
        let padding:CGFloat = 10
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfColumns - 1) * spaceBetweenCells) / numberOfColumns
        return CGSize(width: cellDimension, height: cellDimension)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == bannerCollectionView{
            self.pageControl.currentPage = indexPath.row

        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bannerCollectionView{
            let viewModel = homeViewModel.getBannerAtIndex(index: indexPath.row)
            openLink(stringURL: viewModel.link)
        }else{
            let category = homeViewModel.getCategoriesAtIndex(index: indexPath.row)
            performSegue(withIdentifier: "openDetail", sender: category)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openDetail", let item = sender as? CategoryViewModel{
            guard let targetController = segue.destination as? DetailViewController else{
              
                return}
            
            targetController.categoryId = item.id
        }else if segue.identifier == "goToDetail", let item = sender as? Produto{
            guard let targetController = segue.destination as? ProductViewController else{
                return
            }
            
            targetController.product = item
            
        }
    }
    
    
    func openLink(stringURL:String){
            let urlFormatted = stringURL
            guard let url = URL(string: urlFormatted) else { return }
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController, animated: true, completion: nil)
    }
    

}

extension HomeViewController:UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = homeViewModel.getProductAtIndex(index: indexPath.row)
        performSegue(withIdentifier: "goToDetail", sender: item)

    }
}

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
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!

    private var collectionBannerDataSource:CollectionViewDataSource<BannerCollectionViewCell, BannerViewModel>!
    var homeViewModel = HomeViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.hidesForSinglePage = true
   
       // BannerCollectionViewCell.register(to: bannerCollectionView)

        homeViewModel.loadBanners {
            self.setupBannerCollectionView()
        }
        // Do any additional setup after loading the view.
    }
    
    func setupBannerCollectionView(){
        self.collectionBannerDataSource = CollectionViewDataSource(cellIdentifier: "BannerCollectionViewCell", items: self.homeViewModel.listOfItems, configureCell: { (cell, viewModel) in
            
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
        let numberOfColumns: CGFloat = 1
        
        let spaceBetweenCells:CGFloat = 10
        let padding:CGFloat = 0
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfColumns - 1) * spaceBetweenCells) / numberOfColumns
        return CGSize(width: cellDimension, height: cellDimension)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bannerCollectionView{
            let viewModel = homeViewModel.getBannerAtIndex(index: indexPath.row)
            openLink(stringURL: viewModel.link)
        }
        
    }
    
    
    func openLink(stringURL:String){
            let urlFormatted = stringURL
            guard let url = URL(string: urlFormatted) else { return }
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController, animated: true, completion: nil)
    }
    

}

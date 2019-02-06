//
//  HomePresenter.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class HomePresenter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeVCDelegate {
    let homeView = HomeVC(nibName: "HomeVC", bundle: Bundle.main)
    let homeInteractor = HomeInteractor()
    
    override init() {
        super.init()
        homeView.delegate = self
    }
    
    //MARK: - Home Delegate
    
    func registerCollectionDelegate(){
        homeView.bannerCollection.delegate = self
        homeView.bannerCollection.dataSource = self
        
        homeView.categoryCollection.delegate = self
        homeView.categoryCollection.dataSource = self
    }
    
    func didLoad(){
        registerCollectionDelegate()
        
        homeInteractor.loadHomeContent {
            self.homeView.bannerCollection.reloadData()
            self.homeView.categoryCollection.reloadData()
        }
    }
    
    //MARK: - UI Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case homeView.bannerCollection:
            return homeInteractor.bannerList.count
        case homeView.categoryCollection:
            return homeInteractor.categoryList.count
        case homeView.productCollection:
            return homeInteractor.productList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case homeView.bannerCollection:
            let cell: BannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: kBannerCell, for: indexPath) as! BannerCell
            
            let banner = homeInteractor.bannerList[indexPath.row]
            cell.bind(banner: banner)
            
            return cell
        case homeView.categoryCollection:
            let cell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: kCategoryCell, for: indexPath) as! CategoryCell
            
            let category = homeInteractor.categoryList[indexPath.row]
            cell.bind(category: category)
            
            return cell
        case homeView.productCollection:
            let cell: BannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: kBannerCell, for: indexPath) as! BannerCell
            
            let banner = homeInteractor.bannerList[indexPath.row]
            cell.bind(banner: banner)
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    //MARK: - UI Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let content = self.movies[indexPath.row]
        //MainRouter().showMovieDetail(movie: content)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if homeView.bannerCollection == scrollView{
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            homeView.bannerPageControl.currentPage = Int(pageNumber)
        }
    }
    
    //MARK: - UI Collection View Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case homeView.bannerCollection:
            return homeView.bannerCollection.frame.size
        case homeView.categoryCollection:
            return CGSize(width: homeView.categoryCollection.frame.height * 0.8, height: homeView.categoryCollection.frame.height)
        case homeView.productCollection:
            return homeView.bannerCollection.frame.size
        default:
            return CGSize(width: 0.0, height: 0.0)
        }
    }
}

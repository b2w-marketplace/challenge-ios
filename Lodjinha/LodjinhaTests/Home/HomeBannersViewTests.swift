//
//  HomeBannersViewTests.swift
//  LodjinhaTests
//
//  Created by Douglas da Silva Santos on 25/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import XCTest
@testable import Lodjinha

class HomeBannersViewTests: XCTestCase {

    var sut: HomeBannersView!
    
    func test_UpdateBannersWithBannersData_UpdateBannersCount() {
        sut = HomeBannersView(frame: CGRect.zero)
        sut.updateBanners(banners: ["Banner1", "Banner2", "Banner3"])
        XCTAssertTrue(sut.bannersCount > 0)
    }
    
    func test_UpdateBannersWithBannersData_reloadsCollectionView() {
        sut = HomeBannersView(frame: CGRect.zero)
        sut.updateBanners(banners: ["Banner1", "Banner2", "Banner3"])
        XCTAssertTrue(sut.collectionView.numberOfItems(inSection: 0) == sut.bannersCount)
    }
    
    func test_BannersViewCell_ShouldExpandTheEntireWidth() {
        sut = HomeBannersView(frame: CGRect.zero)
        sut.updateBanners(banners: ["Banner1", "Banner2", "Banner3"])
        let cell = sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(cell.frame.width, sut.collectionView.frame.width)
    }
    
    func test_ShouldScrollHorizontally() {
        sut = HomeBannersView(frame: CGRect.zero)
        sut.updateBanners(banners: ["Banner1", "Banner2", "Banner3"])
        XCTAssertTrue(sut.collectionView.collectionViewLayout.isKind(of: UICollectionViewFlowLayout.self))
        XCTAssertEqual((sut.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection, .horizontal)
    }
    
    func test_shouldGoToNextItem_WhenScrollingAtLeastTwentyPercentOfTheCurrentItem() {
        sut = HomeBannersView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        sut.updateBanners(banners: ["Banner1", "Banner2", "Banner3"])
        sut.layoutIfNeeded()
    
        let cellWidth = sut.collectionView.frame.width
        let lowerBound = cellWidth * CGFloat(sut.currentBanner)
        
        let rectScrolled = CGRect(x: lowerBound + (cellWidth / 5), y: 0, width: sut.collectionView.frame.width, height: sut.collectionView.frame.height)
        let currentBanner = sut.currentBanner
        
        sut.collectionView.setContentOffset(rectScrolled.origin, animated: false)
        let dele = sut.collectionView.delegate
        dele!.scrollViewDidEndDragging!(sut.collectionView, willDecelerate: false)
        
        XCTAssertTrue(sut.currentBanner == currentBanner + 1)
    }
    
    func test_shouldStayInCurrentItem_WhenScrollingAtLeastTwentyPercentOfTheCurrentItem_andTheCurrentItemIsTheLastItem() {
        sut = HomeBannersView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        sut.updateBanners(banners: ["Banner1", "Banner2", "Banner3"])
        sut.layoutIfNeeded()
        sut.currentBanner = sut.bannersCount - 1
        let lastBanner = sut.currentBanner

        let cellWidth = sut.collectionView.frame.width
        let lowerBound = cellWidth * CGFloat(sut.currentBanner)
        let rectScrolled = CGRect(x: lowerBound + (cellWidth  / 5), y: 0, width: sut.collectionView.frame.width, height: sut.collectionView.frame.height)
        sut.collectionView.setContentOffset(rectScrolled.origin, animated: false)
        let dele = sut.collectionView.delegate
        dele!.scrollViewDidEndDragging!(sut.collectionView, willDecelerate: false)
        
        XCTAssertTrue(sut.currentBanner == lastBanner)
    }
    
    func test_shouldGoToPreviousItem_WhenScrollingAtLeastTwentyPercentBackIntTheCurrentItem() {
        sut = HomeBannersView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        sut.updateBanners(banners: ["Banner1", "Banner2", "Banner3"])
        sut.layoutIfNeeded()
        
        sut.currentBanner = 1
        let lastBanner = sut.currentBanner
        
        let cellWidth = sut.collectionView.frame.width
        let lowerBound = cellWidth * CGFloat(sut.currentBanner)
        
        let rectScrolled = CGRect(x: lowerBound - (cellWidth / 5), y: 0, width: sut.collectionView.frame.width, height: sut.collectionView.frame.height)
        
        sut.collectionView.setContentOffset(rectScrolled.origin, animated: false)
        let dele = sut.collectionView.delegate
        dele!.scrollViewDidEndDragging!(sut.collectionView, willDecelerate: false)
        
        XCTAssertTrue(sut.currentBanner == lastBanner - 1)
    }
}

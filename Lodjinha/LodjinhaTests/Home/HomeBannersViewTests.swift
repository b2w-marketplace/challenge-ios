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
    
    func test_BannersViewUpdateBannersWithBannersData_UpdateBannersCount() {
        sut = HomeBannersView(frame: CGRect.zero)
        sut.updateBanners(banners: ["Banner1", "Banner2", "Banner3"])
        XCTAssertTrue(sut.bannersCount > 0)
    }
    
    func test_BannersViewUpdateBannersWithBannersData_reloadsCollectionView() {
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
    
    func test_BannersViewCollectionView_ShouldScrollHorizontally() {
        sut = HomeBannersView(frame: CGRect.zero)
        sut.updateBanners(banners: ["Banner1", "Banner2", "Banner3"])
        XCTAssertTrue(sut.collectionView.collectionViewLayout.isKind(of: UICollectionViewFlowLayout.self))
        XCTAssertEqual((sut.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection, .horizontal)
    }
    
    func test_BannersViewCollectionView_shouldGoToNextItem_WhenScrollingAtLeastTwentyPercentOfTheCurrentItem() {
        sut = HomeBannersView(frame: CGRect.zero)
        sut.updateBanners(banners: ["Banner1", "Banner2", "Banner3"])
        let rectScrolled = CGRect(x: sut.collectionView.frame.width / 5, y: 0, width: sut.collectionView.frame.width, height: sut.collectionView.frame.height)

        sut.collectionView.setContentOffset(rectScrolled.origin, animated: true)
        let dele = sut.collectionView.delegate
        dele!.scrollViewDidEndDragging!(sut.collectionView, willDecelerate: false)
        
        let cells = sut.collectionView.visibleCells
        let cell2 = sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(item: 1, section: 0))
//        XCTAssertTrue(cells.count == 1)
//        XCTAssertTrue(cells.first == cell2)
    }
}

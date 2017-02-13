//
//  UIScrollView.swift
//  Lojinha
//
//  Created by Rodrigo A E Miyashiro on 12/02/17.
//  Copyright © 2017 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

extension HomeViewController: UIScrollViewDelegate
{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let cell = homeTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! BannerTableViewCell
        
        let pageWidth:CGFloat = cell.scrollViewToBanner.frame.width
        let contentOffset:CGFloat = cell.scrollViewToBanner.contentOffset.x
        let currentPage:CGFloat = floor((contentOffset - pageWidth / 2) / pageWidth) + 1
        // Change the indicator
        cell.pageControl.currentPage = Int(currentPage)
    }
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView)
    {
        let cell = homeTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! BannerTableViewCell
        
        let pageWidth:CGFloat = cell.scrollViewToBanner.frame.width
        let maxWidth = pageWidth * CGFloat(self.banners.count)
        let contentOffset:CGFloat = cell.scrollViewToBanner.contentOffset.x
        let currentPage:CGFloat = floor((contentOffset - pageWidth / 2) / pageWidth) + 1
        let translation = scrollView.panGestureRecognizer.translation(in: cell.scrollViewToBanner.superview!)
        
        if translation.x > 0 && currentPage == 0
        {
            cell.scrollViewToBanner.scrollRectToVisible(CGRect(x:cell.scrollViewToBanner.frame.width * CGFloat(self.banners.count - 1), y:0, width:pageWidth, height:cell.scrollViewToBanner.frame.height), animated: true)
            cell.pageControl.currentPage = Int(maxWidth)
        }
        if translation.x < 0 && currentPage == CGFloat(self.banners.count - 1)
        {
            cell.scrollViewToBanner.scrollRectToVisible(CGRect(x:0, y:0, width:pageWidth, height:cell.scrollViewToBanner.frame.height), animated: true)
            cell.pageControl.currentPage = Int(0)
        }
    }
}

//
//  BannerTableViewCell.swift
//  Lojinha
//
//  Created by Rodrigo A E Miyashiro on 11/02/17.
//  Copyright © 2017 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell
{
    
    // MARK: - IBOutlets
    @IBOutlet weak var scrollViewToBanner: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension BannerTableViewCell: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth:CGFloat = scrollView.frame.width
        let contentOffset:CGFloat = self.scrollViewToBanner.contentOffset.x
        let currentPage:CGFloat = floor((contentOffset - pageWidth / 2) / pageWidth) + 1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
    }
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let pageWidth:CGFloat = scrollView.frame.width
        let maxWidth = pageWidth * 4
        let contentOffset:CGFloat = self.scrollViewToBanner.contentOffset.x
        let currentPage:CGFloat = floor((contentOffset - pageWidth / 2) / pageWidth) + 1
        
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!)
        if translation.x > 0 && currentPage == 0{
            self.scrollViewToBanner.scrollRectToVisible(CGRect(x:maxWidth, y:0, width:pageWidth, height:self.scrollViewToBanner.frame.height), animated: true)
            self.pageControl.currentPage = Int(maxWidth)
        }
        if contentOffset + pageWidth > maxWidth {
            self.scrollViewToBanner.scrollRectToVisible(CGRect(x:0, y:0, width:pageWidth, height:self.scrollViewToBanner.frame.height), animated: true)
            self.pageControl.currentPage = Int(0)
        }
    }
}

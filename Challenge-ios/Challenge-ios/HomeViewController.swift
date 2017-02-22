//
//  HomeViewController.swift
//  Challenge-ios
//
//  Created by Roberto Luiz Veiga Junior on 16/02/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var acLoadingBanner: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var tableView: UITableView!
    
    var categories = [Category()]
    var banners = [Banner()]
	var products = [Product()]
	var viewScroll = UIView()
    var bannerPosition = 0
    var bannerTotalWidth:CGFloat = 0
	let SGDETAILFROMHOME = "sgDetailFromHome"
    let SGCATEGORY = "sgCategory"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCommon()
	}
    
    func initCommon() {
        self.loadCategory()
        self.loadBanner()
        self.loadProduct()
    }
    
	func buildBanner(link:String, image: UIImage, position: CGFloat) {
        let xPosition = self.view.frame.width * position
        let banner = UIButton(frame: CGRect(x: xPosition, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height))
		banner.setImage(image, for: .normal)
        banner.setTitle(link, for: .normal)
        banner.addTarget(self, action: #selector(HomeViewController.openInternetPage(_:)), for: .touchUpInside)
        if position > 0.0 {
            self.scrollView.contentSize.width = self.scrollView.frame.width * (position)
        } else {
            self.scrollView.contentSize.width = self.scrollView.frame.width + self.scrollView.contentSize.width
        }
        self.scrollView.addSubview(banner)
    }
    
    @IBAction func openInternetPage(_ sender: UIButton) {
        let url = sender.currentTitle
        UIApplication.shared.openURL(NSURL(string: url!)! as URL)
    }

	fileprivate func loadProduct() {
		Product().getTopProducts { listProduct in
			self.products = listProduct
			self.tableView.reloadData()
		}
	}
    
    fileprivate func loadBanner() {
        Banner().getAll { listBanner in
            self.banners = listBanner
            self.pageControl.numberOfPages = self.banners.count
			for (index,banner) in self.banners.enumerated() {
				if let img = banner.image {
					Banner.downloadImage(url: img) { image in
                    self.buildBanner(link: banner.link , image: image, position: CGFloat(index))
					}
				}
                    
			}
            self.acLoadingBanner.stopAnimating()
        }
	}

    fileprivate func loadCategory() {
        Category().getAll { listCategory in
            self.categories = listCategory
            self.collectionView.reloadData()
        }
    }
    
    //ScrollView
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }

	//TableView
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.products.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: "CELTABLEVIEW" ,
			for: indexPath) as! ProductTableViewCell
		if self.products.count > 0 {
			cell.load(product: self.products[indexPath.row])
		}
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = self.products[indexPath.row]
		self.performSegue(withIdentifier: self.SGDETAILFROMHOME, sender: item)
	}

	// CollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CELLCOLLETION" ,
            for: indexPath) as! MyCollectionViewCell
        if self.categories.count > 0 {
            cell.load(category: self.categories[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category =  self.categories[indexPath.row]
        self.performSegue(withIdentifier: self.SGCATEGORY, sender: category)
    }

    @IBAction func changePageControl(_ sender: UIPageControl) {
        let position = sender.currentPage
        self.scrollView.setContentOffset(CGPoint(x: self.viewScroll.frame.width*CGFloat(position), y: 0), animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == self.SGDETAILFROMHOME {
			let view = segue.destination as! DetailViewController
			view.product = sender as! Product
        } else if segue.identifier == self.SGCATEGORY {
            let view = segue.destination as! ProductsViewController
            view.category = sender as! Category
        }
    }

}

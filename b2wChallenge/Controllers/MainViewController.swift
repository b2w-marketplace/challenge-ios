//
//  ViewController.swift
//  b2wChallenge
//
//  Created by Felipe Mac on 9/5/18.
//  Copyright © 2018 Felipe Mac. All rights reserved.
//

import UIKit
import Alamofire
import FSPagerView

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource,FSPagerViewDataSource,FSPagerViewDelegate {
    
    @IBOutlet weak var bannerPageView: FSPagerView! {
        didSet {
            self.bannerPageView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.bannerPageView.itemSize = .zero
        }
    }
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = imageNames.count
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    fileprivate var imageNames = [String]()
    @IBOutlet weak var produtosTableView: UITableView!
    @IBOutlet weak var categoriasCollectionView: UICollectionView!
    
    var arrayMaisVendidos : [[String:AnyObject]] = []
    var arrayCategorias : [[String:AnyObject]] = []

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setNavigationTitleWithImage()
        Utils.formatNavigationController(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegatesAndDataSources()

        DispatchQueue.main.async {
            Utils.setLoadingScreen(view: self.view)
            self.getBanners()
            self.getCategorias()
            self.getMaisVendidos()
        }
    }
    
    func setDelegatesAndDataSources() {
        produtosTableView.delegate = self
        produtosTableView.dataSource = self
        
        categoriasCollectionView.delegate = self
        categoriasCollectionView.dataSource = self
    }
    
    func setNavigationTitleWithImage() {
        let navView = UIView()
        let label = UILabel()
        label.text = "a Lojinha"
        label.font = UIFont(name: "Pacifico-Regular", size: 20)
        label.textColor = UIColor.white
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center
        
        let image = UIImageView()
        image.image = (#imageLiteral(resourceName: "logoSobre"))
        let imageAspect = image.image!.size.width/image.image!.size.height
        image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
        image.contentMode = UIViewContentMode.scaleAspectFit
        
        navView.addSubview(label)
        navView.addSubview(image)
        
        self.navigationItem.titleView = navView
        
        navView.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- FSPagerView DataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = Utils.imageCache.object(forKey: imageNames[index] as AnyObject) as? UIImage
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = index.description+index.description
        return cell
    }
    // MARK:- FSPagerView Delegate
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.pageControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex 
    }

//Delegates CollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrayCategorias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell = categoriasCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoriaCollection", for: indexPath) as? CategoriasCollectionViewCell {
                
                let categoria = DataCategoria(dictionary: arrayCategorias[indexPath.row])
                cell.categoria = categoria
                
                return cell
            }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            if let object = categoriasCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoriaCollection", for: indexPath) as? CategoriasCollectionViewCell {
                
                let categoria = DataCategoria(dictionary: arrayCategorias[indexPath.row])
                object.categoria = categoria
                
                if let t = storyboard?.instantiateViewController(withIdentifier: "CategoriasList") as? CategoriaListViewController {
                    
                    t.selectedProduct = categoria
                    navigationController?.pushViewController(t, animated: true)
                    
                }
            }
        }
    
//Delegates TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMaisVendidos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = produtosTableView.dequeueReusableCell(withIdentifier: "MaisVendidos", for: indexPath) as? MaisVendidosCell {
                
        let maisVendidos = DataMaisVendidos(dictionary: arrayMaisVendidos[indexPath.row])
        cell.maisVendidos = maisVendidos

        return cell
    }
        return UITableViewCell()
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let object = produtosTableView.dequeueReusableCell(withIdentifier: "MaisVendidos", for: indexPath) as? MaisVendidosCell {
            
            let maisVendidos = DataMaisVendidos(dictionary: arrayMaisVendidos[indexPath.row])
            object.maisVendidos = maisVendidos
            
            if let t = storyboard?.instantiateViewController(withIdentifier: "DetalhesProduto") as? DetalhesProdutoViewController {
                
                t.selectedProduct = maisVendidos
                navigationController?.pushViewController(t, animated: true)
            }
        }
    }
    
    //Api's
    func getMaisVendidos() {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        
        manager.request("https://alodjinha.herokuapp.com/produto/maisvendidos", method: .get).responseJSON { response in
            
            switch (response.result) {
            case .success:
                
                if let jsonDict = response.result.value as? [String:AnyObject] {
                    
                    if let data = jsonDict["data"] as? [[String:AnyObject]] {
                        
                        for item in data {
                            self.arrayMaisVendidos.append(item)
                            
                            if let urlImage = item["urlImagem"] as? String, let url = URL(string: urlImage) {
                                if let data = try? Data(contentsOf: url) {
                                    if let imageToCache = UIImage(data: data) {
                                        Utils.imageCache.setObject(imageToCache, forKey: urlImage as AnyObject)
                                    }
                                }
                            }
                        }
                    }
                    self.produtosTableView.reloadData()
                    Utils.removeLoadingScreen(view: self.view)
                }
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func getCategorias() {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        
        manager.request("https://alodjinha.herokuapp.com/categoria", method: .get).responseJSON { response in
            
            switch (response.result) {
            case .success:
                
                if let jsonDict = response.result.value as? [String:AnyObject] {
                    
                    if let data = jsonDict["data"] as? [[String:AnyObject]] {
                        
                        for item in data {
                            self.arrayCategorias.append(item)
                            
                            if let urlImage = item["urlImagem"] as? String, let url = URL(string: urlImage) {
                                if let data = try? Data(contentsOf: url) {
                                    if let imageToCache = UIImage(data: data) {
                                        Utils.imageCache.setObject(imageToCache, forKey: urlImage as AnyObject)
                                    }
                                }
                            }
                        }
                    }
                    self.categoriasCollectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func getBanners() {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        
        manager.request("https://alodjinha.herokuapp.com/banner", method: .get).responseJSON { response in
            
            switch (response.result) {
            case .success:
                
                if let jsonDict = response.result.value as? [String:AnyObject] {
                    
                    if let data = jsonDict["data"] as? [[String:AnyObject]] {
                        
                        for item in data {
                            
                            if let bannerName = item["urlImagem"] as? String {
                                self.imageNames.append(bannerName)
                            }
                            
                            if let urlImage = item["urlImagem"] as? String, let url = URL(string: urlImage) {
                                if let data = try? Data(contentsOf: url) {
                                    if let imageToCache = UIImage(data: data) {
                                        Utils.imageCache.setObject(imageToCache, forKey: urlImage as AnyObject)
                                    }
                                }
                            }
                        }
                        self.pageControl.numberOfPages = self.imageNames.count
                        self.bannerPageView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}



//
//  ViewController.swift
//  Lodjinha-B2W
//
//  Created by Fernanda de Lima on 22/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var categotiaCollectionView: UICollectionView!
    @IBOutlet weak var maisVendidosTableView: UITableView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var bannerControl: UIPageControl!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var indexBanner = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initView()
        initTableview()
        initPageControl()
        initCollection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initView(){
        activityIndicator.center = CGPoint(x: self.view.center.x, y: 10)
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
    }
    
    private func initTableview(){
        //table configuraçoes
        self.maisVendidosTableView.register(UINib(nibName: "ProdutoViewCell", bundle: nil), forCellReuseIdentifier: "produtoCell")
        
        self.maisVendidosTableView.estimatedRowHeight = 94
        self.maisVendidosTableView.rowHeight = UITableViewAutomaticDimension
        
        LodjinhaAPI.get(InfoProduto.self, url: "https://alodjinha.herokuapp.com/produto/maisvendidos", finish: {
            print("Fim")
        }, success: { (item) in
            mm.maisVnedido = item
            self.maisVendidosTableView.reloadData()
        }) { (error, code) in
            print("--- ERROR \(error.localizedDescription) --- CODE \(code ?? 0)")
        }
    }
    
    private func initCollection(){
        LodjinhaAPI.get(InfoCategoria.self, url: "https://alodjinha.herokuapp.com/categoria", finish: {
            print("Fim")
        }, success: { (item) in

            mm.categoria = item
            self.categotiaCollectionView.reloadData()
        }) { (error, code) in
            print("--- ERROR \(error.localizedDescription) --- CODE \(code ?? 0)")
        }
    }
    
    private func initPageControl(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.changeBanner(sender:)))
        swipeLeft.direction = .left
        bannerView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.changeBanner(sender:)))
        swipeRight.direction = .right
        bannerView.addGestureRecognizer(swipeRight)
        
        LodjinhaAPI.get(InfoBanner.self, url: "https://alodjinha.herokuapp.com/banner", finish: {
            print("Fim")
        }, success: { (item) in
            mm.banner = item
            self.bannerControl.numberOfPages = mm.banner?.data?.count ?? 0
            let dataImg = try? Data(contentsOf: URL(string: (mm.banner?.data?.first?.urlImagem)!)!)
            self.bannerImage.image = UIImage(data: dataImg!)
            mm.banner?.data?.first?.image = UIImage(data: dataImg!)
            
        }) { (error, code) in
            print("--- ERROR \(error.localizedDescription) --- CODE \(code ?? 0)")
        }
        
    }
    
    @objc func changeBanner(sender: UISwipeGestureRecognizer){
        switch sender.direction {
        case .left:
            if indexBanner + 1 >= (mm.banner?.data?.count)!{
                indexBanner = 0
            }else{
                indexBanner += 1
            }
            
            if let image = mm.banner?.data![indexBanner].image{
                self.bannerImage.image = image
            }else{
                let dataImg = try? Data(contentsOf: URL(string: (mm.banner?.data![indexBanner].urlImagem)!)!)
                self.bannerImage.image = UIImage(data: dataImg!)
                mm.banner?.data?[self.indexBanner].image = UIImage(data: dataImg!)
            }
            
            self.bannerControl.currentPage = indexBanner
        case .right:
            
            if indexBanner - 1 < 0{
                indexBanner = (mm.banner?.data?.count)! - 1
            }else{
                indexBanner -= 1
            }
            
            if let image = mm.banner?.data![indexBanner].image{
                self.bannerImage.image = image
            }else{
                let dataImg = try? Data(contentsOf: URL(string: (mm.banner?.data![indexBanner].urlImagem)!)!)
                self.bannerImage.image = UIImage(data: dataImg!)
                mm.banner?.data?[self.indexBanner].image = UIImage(data: dataImg!)
            }
            
            self.bannerControl.currentPage = indexBanner
        default:
            break
        }
    }
    

}


//
//  HomeViewController.swift
//  Lodginha
//
//  Created by Ricardo Bailoni on 22/04/2018.
//  Copyright © 2018 Ricardo Bailoni. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var svBanner: UIScrollView!
    @IBOutlet weak var svCategoria: UIScrollView!
    @IBOutlet weak var vwLoadBanner: UIView!
    @IBOutlet weak var vwLoadCategoria: UIView!
    @IBOutlet weak var ivErrorLoadBanner: UIImageView!
    @IBOutlet weak var ivErrorLoadCategoria: UIImageView!
    @IBOutlet weak var avLoadBanner: UIActivityIndicatorView!
    @IBOutlet weak var avLoadCategoria: UIActivityIndicatorView!
    @IBOutlet weak var tbProdutosMaisVendidos: UITableView!
    @IBOutlet weak var pcBanners: UIPageControl!
    
    lazy var bannerManager: BannerManager = {
        return BannerManager()
    }()
    lazy var categoriaManager: CategoriaManager = {
        return CategoriaManager()
    }()
    lazy var produtoManager: ProdutoManager = {
        return ProdutoManager()
    }()
    
    var banners: [Banner]?
    var categorias: [Categoria]?
    var produtos: [Produto]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageLogoNavBar = UIImage(named: "logoNavbar")
        let imageViewLogoNavBar = UIImageView(image: imageLogoNavBar)
        self.navigationItem.titleView = imageViewLogoNavBar
        tbProdutosMaisVendidos.dataSource = self
        svBanner.delegate = self
        
        bannerManager.delegate = self
        bannerManager.showBanners()
        
        categoriaManager.delegate = self
        categoriaManager.showCategorias()
        
        produtoManager.delegate = self
        produtoManager.showProdutosMaisVendidos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    func addBanners() {
        DispatchQueue.main.async {
            guard let banners = self.banners else {
                return
            }
            self.svBanner.contentSize.width = self.view.bounds.width * CGFloat(banners.count)
            
            for (index, banner) in banners.enumerated() {
                if let bannerView = Bundle.main.loadNibNamed("BannerView", owner: self, options: nil)?.first as? BannerView {
                    bannerView.banner = banner
                    bannerView.ivBanner.contentMode = .scaleToFill
                    self.svBanner.addSubview(bannerView)
                    bannerView.frame.size.width = self.svBanner.bounds.size.width
                    bannerView.frame.origin.x = CGFloat(index)  * self.view.bounds.size.width
                }
            }
            self.pcBanners.numberOfPages = banners.count
            self.vwLoadBanner.isHidden = true
        }
    }
    
    func addCategorias() {
        DispatchQueue.main.async {
            guard let categorias = self.categorias else {
                return
            }
            self.svCategoria.contentSize.width = 94.0 * CGFloat(categorias.count)
            
            for (index, categoria) in categorias.enumerated() {
                if let categoriaView = Bundle.main.loadNibNamed("CategoriaView", owner: self, options: nil)?.first as? CategoriaView {
                    categoriaView.categoria = categoria
                    categoriaView.btCategoria.tag = index
                    categoriaView.btCategoria.addTarget(self, action: #selector(self.showCategoria(sender:)), for: .touchUpInside)
                    self.svCategoria.addSubview(categoriaView)
                    categoriaView.frame.size = CGSize(width: 90, height: 100)
                    categoriaView.frame.origin.x = (CGFloat(index) * 94.0) + 2.0
                }
            }
            self.vwLoadCategoria.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProdutoCategoriaSegue" {
            let sender = sender as! UIButton
            let categoria = categorias![sender.tag]
            let vcDestination = segue.destination as! ProdutosViewController
            vcDestination.categoria = categoria
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        } else if segue.identifier == "DetalheProdutoSegue" {
            let vcDestination = segue.destination as! DetalheProdutoViewController
            guard let produtos = produtos, let selectedRow = tbProdutosMaisVendidos.indexPathForSelectedRow?.row else {
                return
            }
            vcDestination.produto = produtos[selectedRow]
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        }
    }
    
    @objc func showCategoria(sender: UIButton) {
        performSegue(withIdentifier: "ProdutoCategoriaSegue", sender: sender)
    }
    
    func clearScrollView(sv: UIScrollView) {
        DispatchQueue.main.async {
            for subview in sv.subviews {
                subview.removeFromSuperview()
            }
        }
    }
}

extension HomeViewController: CategoriaManagerDelegate {
    func finishLoadCategorias(manager: CategoriaManager, result: CategoriasResult) {
        guard result.error == nil else {
            DispatchQueue.main.async {
                self.ivErrorLoadCategoria.isHidden = false
                self.avLoadCategoria.isHidden = true
                let alert = CustomAlert.loadAlert(type: .error, message: result.error!)
                self.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        if result.categorias != nil {
            self.categorias = result.categorias
            addCategorias()
        }
    }
}

extension HomeViewController: BannerManagerDelegate {
    func finishLoadBanners(manager: BannerManager, result: BannersResult) {
        guard result.error == nil else {
            DispatchQueue.main.async {
                self.ivErrorLoadBanner.isHidden = false
                self.avLoadBanner.isHidden = true
                let alert = CustomAlert.loadAlert(type: .error, message: result.error!)
                self.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        if result.banners != nil {
            self.banners = result.banners
            addBanners()
        }
    }
}

extension HomeViewController: ProdutoManagerDelegate {
    func finishLoadProdutos(manager: ProdutoManager, result: ProdutosResult) {
        guard result.error == nil else {
            DispatchQueue.main.async {
                let alert = CustomAlert.loadAlert(type: .error, message: result.error!)
                self.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        if result.produtos != nil {
            produtos = result.produtos
            DispatchQueue.main.async {
                self.tbProdutosMaisVendidos.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutoCell", for: indexPath) as! ProdutoCell
        guard let produtos = produtos else {
            return UITableViewCell()
        }
        cell.produtoView.produto = produtos[indexPath.row]
        return cell
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.svBanner {
            pcBanners.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        }
    }
}

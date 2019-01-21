//
//  FirstViewController.swift
//  LodjinhaMarketPlace
//
//  Created by Elias Amigo on 20/01/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import UIKit
import SwiftyJSON

private let reusableCellIdentifier = "itemDescription"

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var itemTableView: UITableView!
    
    private var bannerCollectionViewController: BannerCollectionViewController!
    private var productBestSellers = [Product]()
    private var product: Product?
    private var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentData(_:)), name: .ProductBestSellers, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(presentDetails(_:)), name: .ProductDetail, object: nil)
    
        bannerCollectionViewController = BannerCollectionViewController(nibName: "BannerCollectionViewController", bundle: nil)
        
        let collectionViewWrapper = bannerCollectionViewController.view
        collectionViewWrapper?.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChild(bannerCollectionViewController)
        bannerCollectionViewController.didMove(toParent: self)
        self.view.addSubview(collectionViewWrapper!)
        
        let heightConstraint = NSLayoutConstraint(item: collectionViewWrapper!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 170)
        let widthConstraint = NSLayoutConstraint(item: collectionViewWrapper!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.view.frame.width)
        
        let constraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["collectionView":collectionViewWrapper!])
        let constraintTop = NSLayoutConstraint(item: collectionViewWrapper!, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        collectionViewWrapper?.addConstraints([heightConstraint, widthConstraint])
        
        view.addConstraints(constraintsH)
        view.addConstraint(constraintTop)
        
        // Category
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        
        // Title View
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: -15, width: 0, height: 0))
        subtitleLabel.attributedText = NSMutableAttributedString(string: "a Lodjinha",  attributes: [.font: UIFont(name: "Pacifico-Regular", size: 22.0)!, .foregroundColor: UIColor.white, .backgroundColor: UIColor.clear, .kern: 0.0])
        subtitleLabel.sizeToFit()
        
        let titleViewFrame = CGRect(x: 0, y: 0, width: subtitleLabel.frame.size.width, height: 30)
        let titleView = UIView(frame: titleViewFrame)
        titleView.backgroundColor = UIColor.clear
        
        var adjustment = subtitleLabel.frame
        adjustment.origin.x = titleView.frame.origin.x + (titleView.frame.width/2) - (subtitleLabel.frame.width/2)
        subtitleLabel.frame = adjustment
        titleView.addSubview(subtitleLabel)
        
        self.navigationController?.navigationBar.topItem?.titleView = titleView
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Arraste para atualizar")
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: UIControl.Event.valueChanged)
        itemTableView.addSubview(refreshControl)
        
        HTTPServices.requestBestSellers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func presentData(_ notification: NSNotification) {
        
        if refreshControl.isRefreshing { refreshControl.endRefreshing() }
        
        if let validCode = notification.userInfo?["resultSuccess"] as? Bool, validCode {
            let jsonResult = JSON.init(parseJSON: (notification.userInfo!["resultData"] as? String)!)
            
            for data in jsonResult["data"] {
                productBestSellers.append(Product(id: data.1["id"].int, nome: data.1["nome"].string, urlImagem: data.1["urlImagem"].string, descricao: data.1["descricao"].string, precoDe: data.1["precoDe"].double, precoPor: data.1["precoPor"].double, categoria: ProductCategory(id: data.1["categoria"]["id"].int, descricao: data.1["categoria"]["descricao"].string, urlImagem: data.1["categoria"]["urlImagem"].string)))
            }
    
            itemTableView.reloadData()
            
        } else {
            showAlert("Erro de Serviço")
        }
    }
    
    @objc func refreshData(_ sender: Any?) {
        HTTPServices.requestBestSellers()
    }
    
    @objc func presentDetails(_ notification: NSNotification) {
        
        if let validCode = notification.userInfo?["resultSuccess"] as? Bool, validCode {
            let jsonResult = JSON.init(parseJSON: (notification.userInfo!["resultData"] as? String)!)
            
            product = Product(id: jsonResult["id"].int, nome: jsonResult["nome"].string, urlImagem: jsonResult["urlImagem"].string, descricao: jsonResult["descricao"].string, precoDe: jsonResult["precoDe"].double, precoPor: jsonResult["precoPor"].double, categoria: ProductCategory(id: jsonResult["categoria"]["id"].int, descricao: jsonResult["categoria"]["descricao"].string, urlImagem: jsonResult["categoria"]["urlImagem"].string))
            
            performSegue(withIdentifier: "viewDetails", sender: nil)
            
        } else {
            showAlert("Erro de Serviço")
        }
    }
    
    private func showAlert(_ message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - UITableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productBestSellers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Mais vendidos"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier) as! ItemDetailTableViewCell
        
        tableView.rowHeight = 140
        
        cell.setItemNewPrice(productBestSellers[indexPath.row].precoPor ?? 9999.99)
        cell.setItemOldPrice(productBestSellers[indexPath.row].precoDe ?? 9999.99)
        cell.setItemDescription(productBestSellers[indexPath.row].nome)
        cell.setItemImage(productBestSellers[indexPath.row].urlImagem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HTTPServices.requestProductDetail(productBestSellers[indexPath.row].id!)
    }
    
    // MARK: - UICollection Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let itemViewController = segue.destination as? ItemDetailViewController else { return }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: nil)
        itemViewController.productDetail = product!
    }
}


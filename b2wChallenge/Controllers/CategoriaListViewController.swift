//
//  CategoriaListViewController.swift
//  b2wChallenge
//
//  Created by Felipe Mac on 11/5/18.
//  Copyright © 2018 Felipe Mac. All rights reserved.
//

import UIKit
import Alamofire

class CategoriaListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var categoriaListTableView: UITableView!
    
    var arrayCategoriaList : [[String:AnyObject]] = []
    var selectedProduct: DataCategoria?
    var offset = 0
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let descriptionCategory = selectedProduct?.descricao {
            Utils.formatNavigationTitleFontWithDefaultStyle(view: self, description: descriptionCategory)
        }
                
        categoriaListTableView.delegate = self
        categoriaListTableView.dataSource = self
        
        if let id = selectedProduct?.id {
            getCategoriesById(id)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func validateResultZero() {
        if arrayCategoriaList.count == 0 {
            let alert = UIAlertController(title: "a Lojinha", message: "Não temos produtos nesta categoria neste momento, Obrigado", preferredStyle: UIAlertControllerStyle.alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
                Utils.removeLoadingScreen(view: self.view)
                self.navigationController?.popViewController(animated: true)
                
            }
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        }else{
            categoriaListTableView.reloadData()
        }
    }
    
    //Delegates TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCategoriaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = categoriaListTableView.dequeueReusableCell(withIdentifier: "MaisVendidos", for: indexPath) as? MaisVendidosCell {
            
            let maisVendidos = DataMaisVendidos(dictionary: arrayCategoriaList[indexPath.row])
            cell.maisVendidos = maisVendidos
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let object = categoriaListTableView.dequeueReusableCell(withIdentifier: "MaisVendidos", for: indexPath) as? MaisVendidosCell {
            
            let maisVendidos = DataMaisVendidos(dictionary: arrayCategoriaList[indexPath.row])
            object.maisVendidos = maisVendidos
            
            if let t = storyboard?.instantiateViewController(withIdentifier: "DetalhesProduto") as? DetalhesProdutoViewController {
                
                t.selectedProduct = maisVendidos
                navigationController?.pushViewController(t, animated: true)
                
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - 1000
        
        if (actualPosition >= contentHeight) {
            offset += 1
            if let id = selectedProduct?.id {
                getCategoriesById(id, offset: offset, presentLoadingView: false)
            }
        }
    }

//Api's
    func getCategoriesById(_ id: Int, offset: Int = 0, presentLoadingView: Bool = true) {
        if presentLoadingView {
            Utils.setLoadingScreen(view: self.view)
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        
        manager.request("https://alodjinha.herokuapp.com/produto?offset=\(offset)&limit=20&categoriaId=\(id)", method: .get).responseJSON { response in
            
            switch (response.result) {
            case .success:
                
                if let jsonDict = response.result.value as? [String:AnyObject] {
                    
                    if let data = jsonDict["data"] as? [[String:AnyObject]] {
                        for item in data {
                            self.arrayCategoriaList.append(item)
                            
                            if Utils.imageCache.object(forKey: item["urlImagem"] as? String as AnyObject) as? UIImage == nil {
                                if let urlImage = item["urlImagem"] as? String, let url = URL(string: urlImage) {
                                    if let data = try? Data(contentsOf: url) {
                                        if let imageToCache = UIImage(data: data) {
                                            Utils.imageCache.setObject(imageToCache, forKey: urlImage as AnyObject)
                                        }
                                    }
                                }
                            }
                        }
                    }                    
                    self.validateResultZero()
                    
                    if presentLoadingView {
                        Utils.removeLoadingScreen(view: self.view)
                    }
                }
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

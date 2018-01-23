//
//  ListaProdutoTableViewController.swift
//  Lodjinha-B2W
//
//  Created by Fernanda on 23/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit

class ListaProdutoTableViewController: UITableViewController {
    
    var idCategoria = 0
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        initTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mm.produto?.data?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "produtoCell", for: indexPath) as! ProdutoViewCell
        cell.nomeProdutoLabel.text = mm.produto?.data![indexPath.row].nome
        cell.deLabel.text = "de \(mm.produto?.data![indexPath.row].precoDe ?? 0)"
        cell.porLabel.text = "Por \(mm.produto?.data![indexPath.row].precoPor ?? 0)"
        let dataImg = try? Data(contentsOf: URL(string: (mm.produto?.data![indexPath.row].urlImagem)!)!)
        if let dataImg = dataImg{
            cell.produtoImage.image = UIImage(data: dataImg)
        }else{
            cell.produtoImage.image = UIImage(named: "semphoto")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "detailsProdutoView") as! DetailsViewController
        detailView.produto = (mm.produto?.data![indexPath.row])!
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func initTable(){
        self.tableView.register(UINib(nibName: "ProdutoViewCell", bundle: nil), forCellReuseIdentifier: "produtoCell")
        
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.hidesWhenStopped = true
        self.tableView.addSubview(activityIndicator)
        
        let queries = ["offset":"20","limit":"20","categoriaId":"\(idCategoria)"]
        var endpoint : String! = "https://alodjinha.herokuapp.com/produto"
        
        if (queries.count > 0) {
            endpoint = String(format: "%@?", endpoint)
            for (key,value) in queries {
                endpoint = String(format: "%@%@=%@&", endpoint,key,value)
            }
            let index = endpoint.index(endpoint.endIndex, offsetBy: -1)
            endpoint = endpoint.substring(to: index)
        }
        
        activityIndicator.startAnimating()
        self.view.alpha = 0.8
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        LodjinhaAPI.get(InfoProduto.self, url: endpoint, finish: {
            self.activityIndicator.stopAnimating()
            self.view.alpha = 1.0
            UIApplication.shared.endIgnoringInteractionEvents()
            print("Fim")
        }, success: { (item) in
            print(item.toJSON())
            mm.produto = item
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.view.alpha = 1.0
            UIApplication.shared.endIgnoringInteractionEvents()
        }) { (error, code) in
            print("--- ERROR \(error.localizedDescription) --- CODE \(code ?? 0)")
            self.activityIndicator.stopAnimating()
            self.view.alpha = 1.0
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        
    }

}

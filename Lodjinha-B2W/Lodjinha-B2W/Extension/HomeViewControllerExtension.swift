//
//  HomeViewControllerExtension.swift
//  Lodjinha-B2W
//
//  Created by Fernanda on 23/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mm.maisVnedido?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "produtoCell", for: indexPath) as! ProdutoViewCell
        cell.nomeProdutoLabel.text = mm.maisVnedido?.data![indexPath.row].nome
        cell.deLabel.text = "de \(mm.maisVnedido?.data![indexPath.row].precoDe ?? 0)"
        cell.porLabel.text = "Por \(mm.maisVnedido?.data![indexPath.row].precoPor ?? 0)"
        let dataImg = try? Data(contentsOf: URL(string: (mm.maisVnedido?.data![indexPath.row].urlImagem)!)!)
        if let dataImg = dataImg{
            cell.produtoImage.image = UIImage(data: dataImg)
        }else{
            cell.produtoImage.image = UIImage(named: "semphoto")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "detailsProdutoView") as! DetailsViewController
        detailView.produto = (mm.maisVnedido?.data![indexPath.row])!
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mm.categoria?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriaCell", for: indexPath) as! CategoriaViewCell
        cell.descricaoLabel.text = mm.categoria?.data![indexPath.row].descricao
        let dataImg = try? Data(contentsOf: URL(string: (mm.categoria?.data![indexPath.row].urlImagem)!)!)
        if let dataImg = dataImg{
            cell.categoriaImage.image = UIImage(data: dataImg)
        }else{
            cell.categoriaImage.image = UIImage(named: "semphoto")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tableViewController = self.storyboard?.instantiateViewController(withIdentifier: "listProdutoTableView") as! ListaProdutoTableViewController
        tableViewController.idCategoria = (mm.categoria?.data![indexPath.row].id)!
        self.navigationController?.pushViewController(tableViewController, animated: true)
    }
    
}

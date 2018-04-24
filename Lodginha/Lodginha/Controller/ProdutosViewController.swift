//
//  ProdutosViewController.swift
//  Lodginha
//
//  Created by Ricardo Bailoni on 23/04/2018.
//  Copyright © 2018 Ricardo Bailoni. All rights reserved.
//

import UIKit

class ProdutosViewController: UIViewController {
    @IBOutlet weak var tvProdutos: UITableView!
    @IBOutlet weak var aivProdutos: UIActivityIndicatorView!
    
    var categoria: Categoria?
    var produtos: [Produto]?
    var temPaginacao = false
    var estaSincronizando = false
    var valTagCellLoading = 12345678
    lazy var produtoManager: ProdutoManager = {
        return ProdutoManager()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        guard let categoria = categoria else { return }
        tvProdutos.dataSource = self
        tvProdutos.delegate = self
        produtoManager.delegate = self
        produtoManager.showProdutosCategoria(id: categoria.id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let categoria = categoria else { return }
        self.title = categoria.descricao
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vcDestination = segue.destination as! DetalheProdutoViewController
        guard let produtos = produtos, let selectedRow = tvProdutos.indexPathForSelectedRow?.row else {
            return
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        vcDestination.produto = produtos[selectedRow]
    }
    
    
}

extension ProdutosViewController: ProdutoManagerDelegate {
    func finishLoadProdutos(manager: ProdutoManager, result: ProdutosResult) {
        let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
            DispatchQueue.main.async {
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        
        DispatchQueue.main.async {
            self.aivProdutos.stopAnimating()
        }
        
        estaSincronizando = false
        
        guard result.error == nil else {
            DispatchQueue.main.async {
                let alert = CustomAlert.loadAlert(type: .error, message: result.error!, actions: [actionOk])
                self.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        if result.produtos != nil {
            if result.produtos!.count > 0 {
                temPaginacao = result.produtos!.count == produtoManager.produtoSinc.limit ? true : false
                if produtos == nil {
                    produtos = result.produtos
                } else {
                    produtos?.append(contentsOf: result.produtos!)
                }
                DispatchQueue.main.async {
                    self.tvProdutos.reloadData()
                }
            } else {
                if produtos?.count == 0 {
                    let alert = CustomAlert.loadAlert(type: .warning, message: "Não existem produtos disponiveis nesta categoria", actions: [actionOk])
                    present(alert, animated: true, completion: nil)
                } else {
                    temPaginacao = false
                    DispatchQueue.main.async {
                        self.tvProdutos.reloadData()
                    }
                }
            }
        }
    }
}

extension ProdutosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberRows = produtos?.count ?? 0
        if temPaginacao {
            numberRows += 1
        }
        return numberRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if temPaginacao && indexPath.row == produtos?.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
            cell.tag = valTagCellLoading
            cell.accessoryType = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutoCell", for: indexPath) as! ProdutoCell
            guard let produtos = produtos else {
                return UITableViewCell()
            }
            cell.produtoView.produto = produtos[indexPath.row]
            return cell
        }
    }
}

extension ProdutosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.tag == valTagCellLoading && estaSincronizando == false {
            let offsetNew = produtoManager.produtoSinc.getOffSet() + produtoManager.produtoSinc.limit
            estaSincronizando = true
            produtoManager.produtoSinc.changeOffSet(to: offsetNew)
            produtoManager.showProdutosCategoria(id: categoria!.id)
        }
    }
}

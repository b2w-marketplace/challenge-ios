//
//  CategoryListDetailViewController.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 15/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class CategoryListDetailViewController: CustomViewController, VisibleView
{
    // MARK: Lets and Vars
    var category: Category!
    var listProductsViewModel: ProductViewMode?
    {
        didSet
        {
            listProductsViewModel?.listProductDidChange = { [weak self] viewModel in
                if viewModel.list?.products.count == 0
                {
                    self?.present(Alert.show(message: "Não há produtos disponíveis no momento..."), animated: true, completion: nil)
                    self?.isView(hide: true)
                }
                else
                {
                    self?.categoryListDetailTableView.reloadData()
                    self?.isView(hide: false)
                }
            }
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var categoryListDetailTableView: UITableView!
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.set(title: category.strDescription)
        
        Spinner.shared.show(view: self.view)
        
        listProductsViewModel = ProductViewMode()
        getProductsByCategory(offSet: 0)
        infinityScroll()
        
        categoryListDetailTableView.tableFooterView = UIView()
    }

    func isView(hide: Bool)
    {
        categoryListDetailTableView.isHidden = hide
        Spinner.shared.stopAnimating()
    }
    
    // MARK: - Request
    private func getProductsByCategory(offSet: Int)
    {
        let url = GenerateURL.get(type: .productByCategory, offset: String(offSet)) + String(category.id)
        listProductsViewModel?.getElement(withURL: url, completion: { (error) in
            if let error = error
            {
                self.isView(hide: true)
                print("-->> Error get product by category [VC]: \(error)")
                self.present(Alert.show(message: error.localizedDescription), animated: true, completion: nil)
            }
        })
    }
    
    private func infinityScroll()
    {
        categoryListDetailTableView.addInfiniteScroll { (tableView) in
            if self.listProductsViewModel?.list?.products.count ?? 0 == Int(NumberOfProductsList.range.rawValue) ?? 0
            {
                let offset = (self.listProductsViewModel?.list?.offset ?? 0) + Int(NumberOfProductsList.range.rawValue)!
                self.getProductsByCategory(offSet: offset)
            }
            
            tableView.finishInfiniteScroll()
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == Segue.detailProduct.rawValue
        {
            let productDetail = segue.destination as! DetailProductViewController
            productDetail.product = (sender as! Product)
        }
    }
}


// MARK: - Extension TableView DataSource
extension CategoryListDetailViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listProductsViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = categoryListDetailTableView.dequeueReusableCell(withIdentifier: CellIdentifier.categoryListCell.rawValue, for: indexPath) as! ProductTableViewCell
        
        let row = indexPath.row
        let product = listProductsViewModel?.list?.products[row]
        cell.product = product
        
        return cell
    }
}


// MARK: - Extension TableView Delegate
extension CategoryListDetailViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        categoryListDetailTableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        let product = listProductsViewModel?.list?.products[row]
        self.performSegue(withIdentifier: Segue.detailProduct.rawValue, sender: product)
    }
}

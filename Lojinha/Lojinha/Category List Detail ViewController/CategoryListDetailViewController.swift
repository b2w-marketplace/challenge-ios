//
//  CategoryListDetailViewController.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 15/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class CategoryListDetailViewController: CustomViewController
{
    // MARK: Lets and Vars
    var categoryID: Int!
    var listProductsViewModel: ProductViewMode?
    {
        didSet
        {
            listProductsViewModel?.listProductDidChange = { [weak self] viewModel in
                self?.categoryListDetailTableView.reloadData()
            }
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var categoryListDetailTableView: UITableView!
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        listProductsViewModel = ProductViewMode()
        getProductsByCategory(offSet: 0)
        
        categoryListDetailTableView.tableFooterView = UIView()
    }

    private func getProductsByCategory(offSet: Int)
    {
        let url = GenerateURL.get(type: .productByCategory, offset: String(offSet)) + String(categoryID)
        listProductsViewModel?.getElement(withURL: url, completion: { (error) in
            if let error = error
            {
                print("-->> Error get product by category [VC]: \(error)")
                self.present(Alert.show(message: error.localizedDescription), animated: true, completion: nil)
            }
        })
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        
    }
}


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
}

//
//  DetailViewController.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var productTableView: UITableView!
    var categoryId:Int?
    var detailViewModel:DetailViewModel!
    private var tableViewBestSellerDataSource:TableViewDataSource<BestSellerTableViewCell, BestSellerViewModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let id = categoryId else{return}
        self.productTableView.isHidden = true
        self.loadingIndicator.startAnimating()
        self.loadingIndicator.isHidden = false

        detailViewModel = DetailViewModel(categoryId: id)
        detailViewModel.loadItems(fromStart: true) {
            self.productTableView.isHidden = false
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            BestSellerTableViewCell.register(to: self.productTableView)
            self.setupTableViewView()
        }
       



        // Do any additional setup after loading the view.
    }
    
    
    func setupTableViewView(){
        self.tableViewBestSellerDataSource = TableViewDataSource(cellIdentifier: "BestSellerTableViewCell", items: self.detailViewModel.listItems, configureCell: { (cell, viewModel) in
            
            cell.setup(viewModel: viewModel)
        })
        self.productTableView.delegate = self
        self.productTableView.dataSource = tableViewBestSellerDataSource
        DispatchQueue.main.async {
            self.productTableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = detailViewModel.getItemAtIndex(index: indexPath.row)
        performSegue(withIdentifier: "goToDetail", sender: item)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail", let item = sender as? Produto{
            guard let targetController = segue.destination as? ProductViewController else{
                return
            }
            
            targetController.product = item
            
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            // print("this is the last cell")
            detailViewModel.loadItems {
                self.tableViewBestSellerDataSource = TableViewDataSource(cellIdentifier: "BestSellerTableViewCell", items: self.detailViewModel.listItems, configureCell: { (cell, viewModel) in
                    
                    cell.setup(viewModel: viewModel)
                })
                self.productTableView.dataSource = self.tableViewBestSellerDataSource

                self.productTableView.reloadData()
                self.productTableView.tableFooterView?.isHidden = true
            }
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.productTableView.tableFooterView = spinner
            self.productTableView.tableFooterView?.isHidden = false
        }
    }
}

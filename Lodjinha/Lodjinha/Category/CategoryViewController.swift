//
//  CategoryViewController.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 28/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var productsTableView: UITableView!
    
    private var titleName: String
    
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = titleName
    }
    
    private func setupTableView() {
        productsTableView.register(UINib(nibName: ProductCell.nameOfClass, bundle: nil), forCellReuseIdentifier: ProductCell.nameOfClass)
        productsTableView.rowHeight = UITableView.automaticDimension
        productsTableView.estimatedRowHeight = 85
    }
    
}

//MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(titleName: "Teste"), animated: true)
    }
    
}

//MARK: - UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.nameOfClass) as! ProductCell
        return cell
    }
    
    
}


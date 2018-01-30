//
//  CategoryViewController.swift
//  lodjaApp
//
//  Created by Rodrigo Marangoni on 26/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoryStack: UIStackView!
    private var categories: Array<Category>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCategories()
    }
    
    func configCategories() {
        for cat in self.categories {
            let categoryView = UINib(nibName: "CategoryView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CategoryView
            categoryView.configureView(cat.descricao, catImage: cat.urlImage)
            categoryView.categoryButton.tag = cat.catId!
            categoryView.categoryButton.addTarget(self, action: #selector(pressButton(_:)), for: .touchUpInside)
            
            self.categoryStack.addArrangedSubview(categoryView)
        }
    }
    
    func getCategories() {
        Alamofire.request(APPURL.GetCategories, method:.get).validate().responseObject { (response: DataResponse<CategoryData>) in
            switch response.result {
            case .success(let value):
                //let jsonData = JSON(value)
                self.categories = value.data
                self.configCategories()
                print("JSON: \(self.categories)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func pressButton(_ button: UIButton) {
        self.performSegue(withIdentifier: "pushToCategory", sender: button.tag)
        print("Button with tag: \(button.tag) clicked!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToCategory" {
            let dest = segue.destination as! CategoryTableViewController
            dest.categoryID = sender as! Int
        }
    }

}

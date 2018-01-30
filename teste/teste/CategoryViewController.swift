//
//  CategoryViewController.swift
//  teste
//
//  Created by Rodrigo Marangoni on 26/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoryStack: UIStackView!
    private var categories: Array<JSON>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCategories()
    }
    
    func configCategories() {
        for cat in self.categories {
            let categoryView = UINib(nibName: "CategoryView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CategoryView
            categoryView.configureView(cat["descricao"].stringValue, catImage: cat["urlImagem"].stringValue)
            self.categoryStack.addArrangedSubview(categoryView)
        }
    }
    
    func getCategories() {
        Alamofire.request(APPURL.GetCategories, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonData = JSON(value)
                self.categories = jsonData["data"].arrayValue
                self.configCategories()
                print("JSON: \(self.categories)")
            case .failure(let error):
                print(error)
            }
        }
    }
    

}

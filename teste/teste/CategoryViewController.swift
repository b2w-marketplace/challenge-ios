//
//  CategoryViewController.swift
//  teste
//
//  Created by Rodrigo Marangoni on 26/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoryStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let category1 = UINib(nibName: "CategoryView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CategoryView
        let category2 = UINib(nibName: "CategoryView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CategoryView
        let category3 = UINib(nibName: "CategoryView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CategoryView
        let category4 = UINib(nibName: "CategoryView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CategoryView
        let category5 = UINib(nibName: "CategoryView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CategoryView
        
        self.categoryStack.addArrangedSubview(category1)
        self.categoryStack.addArrangedSubview(category2)
        self.categoryStack.addArrangedSubview(category3)
        self.categoryStack.addArrangedSubview(category4)
        self.categoryStack.addArrangedSubview(category5)
        
        

        // Do any additional setup after loading the view.
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

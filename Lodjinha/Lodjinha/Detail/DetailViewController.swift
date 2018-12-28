//
//  DetailViewController.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 28/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var promoLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var reserveButton: UIButton!
    
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
        setupButton()
        setupTextView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = titleName
    }
    
    private func setupButton() {
        reserveButton.layer.cornerRadius = 5
        reserveButton.clipsToBounds = true
    }
    
    private func setupTextView() {
        detailsTextView.contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }

}

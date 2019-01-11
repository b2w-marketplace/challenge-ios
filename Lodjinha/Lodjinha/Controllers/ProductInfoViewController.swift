//
//  ProductInfoViewController.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class ProductInfoViewController: UIViewController {

    var productInfoViewModel: ProductInfoViewModel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var productImage: CachedImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var beforePrice: UILabel!
    @IBOutlet weak var afterPrice: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var bookButtonView: UIView!
    @IBOutlet weak var bookButton: UIButton!

    var isLoading = false
    var spinner: UIView?

    @IBAction func bookAction(_ sender: Any) {
        toggleIsLoading()
        NetworkService(withBaseURL: Constants.BaseUrl).reserveProduct(productId: productInfoViewModel.product.id, then: { [weak self] (result) in
            guard let `self` = self else { return }
            if result.isFailure {
                self.displayOkMessage(text: Constants.ErrorMessage)
            } else {
                self.displayOkMessage(text: Constants.BookSuccessMessage)
            }
            self.toggleIsLoading()
        })
    }

    private func toggleIsLoading() {
        isLoading.toggle()
        bookButton.isEnabled = !isLoading
        if let `spinner` = spinner {
            UIViewController.removeSpinner(spinner: spinner)
        } else {
            spinner = UIViewController.displaySpinner(onView: view)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fillData()
        title = productInfoViewModel.product.category?.description ?? productInfoViewModel.product.name
    }

    private func setupViews() {
        view.backgroundColor = .WhiteTwo
        titleLabel.font = Font(.installed(.RobotoBold), size: .standard(.title)).instance
        titleLabel.textColor = .GreyishBrown

        beforePrice.font = Font(.installed(.RobotoMedium), size: .standard(.subtitle)).instance
        beforePrice.textColor = .Greyish

        afterPrice.font = Font(.installed(.RobotoBold), size: .standard(.title)).instance
        afterPrice.textColor = .Tomato

        descriptionView.font = Font(.installed(.RobotoMedium), size: .standard(.descriptionLarge)).instance
        descriptionView.textColor = .Greyish

        bookButtonView.backgroundColor = .WhiteTwo
        bookButtonView.addTopBorder(color: .GreyishBrown, width: 1.0)

        bookButton.backgroundColor = .WarmPurple
        bookButton.setTitleColor(.WhiteTwo, for: .normal)
        bookButton.titleLabel?.font = Font(.installed(.RobotoMedium), size: .standard(.descriptionLarge)).instance

        bookButton.layer.cornerRadius = 10
    }

    private func fillData() {
        titleLabel.text = productInfoViewModel.product.name
        let attributeString = NSMutableAttributedString(string: productInfoViewModel.beforePrice)
        attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        beforePrice.attributedText = attributeString
        afterPrice.text = productInfoViewModel.afterPrice
        descriptionView.attributedText = productInfoViewModel.product.description.convertHtml("Roboto-Regular", 18.0)
        bookButton.setTitle(Constants.Book, for: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        productImage.loadImageFromURL(imageUrl: productInfoViewModel.product.imageUrl)
    }

}

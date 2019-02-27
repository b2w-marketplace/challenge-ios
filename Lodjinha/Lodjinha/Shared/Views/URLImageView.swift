//
//  URLImageView.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class URLImageView: UIImageView {
  var imageUrl: String? {
    didSet {
      fetchImage(from: imageUrl)
    }
  }

  private func fetchImage(from urlString: String?) {
    guard let urlString = urlString else { return }
    if image == nil {
      image = #imageLiteral(resourceName: "placeholder")
    }
    ImageWorker.shared.image(from: urlString) { [weak self] result in
      DispatchQueue.main.async {
        if result?.1 == nil {
          self?.image = #imageLiteral(resourceName: "placeholder")
        } else {
          self?.image = result?.1
        }
      }
    }
  }
}

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
    ImageWorker.shared.image(from: urlString) { [weak self] result in
      DispatchQueue.main.async {
        self?.image = result?.1
      }
    }
  }
}

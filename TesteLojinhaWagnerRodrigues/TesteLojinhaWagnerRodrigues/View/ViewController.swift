//
//  ViewController.swift
//  TesteLojinhaWagnerRodrigues
//
//  Created by Wagner Rodrigues on 10/06/2018.
//  Copyright © 2018 Wagner Rodrigues. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath)
        
        return cell
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageArray = [UIImageView]()
    var banner: Banner!
    var imageArras = [Banner]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        
        
        collectionView.dataSource = self
        let jsonUrlString = "https://alodjinha.herokuapp.com/banner"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                do {
                    let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                    let array = (json as! [AnyHashable: Any])["data"] as? [[AnyHashable: Any]]
                    let test = try JSONSerialization.data(withJSONObject: array ?? [], options: JSONSerialization.WritingOptions.prettyPrinted)
                    
                    self.imageArras = try JSONDecoder().decode([Banner].self, from: test )
                }catch {
                    print("Error Parse")
                    print(error)
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.setupScrollView()
                }
            }
            
            }.resume()
        
    }
    
    fileprivate func setupScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.contentSize.width = scrollView.frame.size.width * CGFloat(imageArras.count)
        for (index, banner) in imageArras.enumerated() {
            guard let url = URL(string: banner.urlImagem) else { return }
            let imageView = UIImageView()
            imageView.frame = CGRect.zero
            imageView.frame.origin.x = CGFloat(index) * scrollView.frame.size.width
            imageView.frame.size = scrollView.frame.size
            imageView.downloadedFrom(url: url)
            imageView.contentMode = .scaleAspectFit
            imageArray.append(imageView)
            scrollView.addSubview(imageView)
        }
    }
    
    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}


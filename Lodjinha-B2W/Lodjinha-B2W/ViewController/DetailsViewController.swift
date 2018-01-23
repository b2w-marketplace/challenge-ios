//
//  DetailsViewController.swift
//  Lodjinha-B2W
//
//  Created by Fernanda on 23/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var produtoImage: UIImageView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var deLabel: UILabel!
    @IBOutlet weak var porLabel: UILabel!
    @IBOutlet weak var descricaoText: UITextView!
    @IBOutlet weak var reservar: UIButton!
    
    @IBAction func reservarActionButton(_ sender: Any) {
        LodjinhaAPI.post("https://alodjinha.herokuapp.com/produto/\(produto?.id ?? 0)", success: { (response) in
            if let _ = response["result"]{
                let alert = UIAlertController(title: "Sucesso", message: "Produto reservado com sucesso", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel, handler: { (alert) in
                    self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Erro", message: "Produto não reservado", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error, code) in
            print("--- ERROR \(error.localizedDescription) --- CODE \(code ?? 0)")
        }
    }
    
    var produto: Produto?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
        self.reservar.layer.cornerRadius = 6
        initValues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func initValues(){
        nomeLabel.text = produto?.nome
        deLabel.text = "de \(produto?.precoDe ?? 0)"
        porLabel.text = "Por \(produto?.precoPor ?? 0)"
        descricaoText.text = produto?.descricao
        
        let dataImg = try? Data(contentsOf: URL(string: (self.produto?.urlImagem!)!)!)
        if let dataImg = dataImg{
            produtoImage.image = UIImage(data: dataImg)
        }else{
            produtoImage.image = UIImage(named: "semphoto")
        }
    }

}

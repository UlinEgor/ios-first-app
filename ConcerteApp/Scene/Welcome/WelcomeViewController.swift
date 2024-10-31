//
//  WelcomeViewController.swift
//  ConcerteApp
//
//  Created by Konstantin Kulakov on 27.10.2024.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    private var now_is_loading = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        statusLabel.text = "Готов к загрузке!"
        activityIndicator.hidesWhenStopped = true
    }
    
    private func downloadCat() {
        guard let url = URL(string: "https://cataas.com/cat") else {
            return;
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return;
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.catImageView.image = UIImage(data: data);
                self?.statusLabel.text = "Загрузка кота закончена";
                self?.activityIndicator.stopAnimating();
                self?.now_is_loading = false;
            }
        }
        
        task.resume();
    }

    
    @IBAction func didTapButton(_ sender: Any) {
        if !now_is_loading {
            now_is_loading = true;
            activityIndicator.startAnimating();
            statusLabel.text = "Начинаю загрузку кота!";
            downloadCat();
        } else {
            statusLabel.text = "Котик уже пытается попать в Ваш телефон";
        }
    }
}


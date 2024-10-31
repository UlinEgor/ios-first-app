//
//  TextedCatViewController.swift
//  ConcerteApp
//
//  Created by Егор Юлин on 31.10.2024.
//

import UIKit

class TextedCatViewController: UIViewController {
    @IBOutlet weak var input_text_bar: UITextField!
    @IBOutlet weak var activity_indicator: UIActivityIndicatorView!
    @IBOutlet weak var status_label: UILabel!
    @IBOutlet weak var generate_cat_button: UIButton!
    @IBOutlet weak var cat_image: UIImageView!
    
    private var now_is_loading = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        status_label.text = "Готов к загрузке!";
        activity_indicator.hidesWhenStopped = true;
    }
    
    private func download_cat(with text: String) {
        guard let url = URL(string: "https://cataas.com/cat/says/\(text)?fontSize=50&fontColor=white") else {
            return;
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return;
            }
        
            DispatchQueue.main.async { [weak self] in
                self?.cat_image.image = UIImage(data: data);
                self?.status_label.text = "Загрузка кота закончена";
                self?.activity_indicator.stopAnimating();
                self?.now_is_loading = false;
            }
        }
        
        task.resume();
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        if let correct_text = input_text_bar.text {
            if correct_text != "" && !now_is_loading {
                activity_indicator.startAnimating();
                status_label.text = "Начинаю загрузку кота!";
                now_is_loading = true;
                
                download_cat(with: correct_text);
            } else if now_is_loading {
                status_label.text = "Котик уже пытается попать в Ваш телефон";
            } else {
                status_label.text = "Поле не должно быть пустым";
            }
        }
    }
}

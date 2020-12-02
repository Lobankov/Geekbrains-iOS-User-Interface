//
//  LoginVC.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 02.12.2020.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        let label = UILabel()
        view.addSubview(label)
        
        label.text = "Login Screen Added"
        label.backgroundColor = .yellow
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

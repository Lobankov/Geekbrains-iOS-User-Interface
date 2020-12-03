//
//  LoginVC.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 02.12.2020.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: UI Components
    
    private var stackView: UIStackView!
    private var loginInput: UITextField!
    private var passwordInput: UITextField!
    private var loginButton: UIButton!
    
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        stackView = UIStackView()
        loginInput = UITextField()
        passwordInput = UITextField()
        loginButton = UIButton()
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(loginInput)
        stackView.addArrangedSubview(passwordInput)
        stackView.addArrangedSubview(loginButton)
        
        setupStackView()
        setupLoginInput()
        setupPasswordInput()
        setupLoginButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: Control handlers
    
    @objc private func handleLoginButtonTap() {
        
    }
    
    // MARK: Helper functions
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Layout
    
    private func setupStackView() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
    
    private func setupLoginInput() {
        
        loginInput.placeholder = "Email или телефон"
        loginInput.autocapitalizationType = .none
        loginInput.font = .systemFont(ofSize: 17)
        loginInput.textColor = .darkGray
        loginInput.backgroundColor = UIColor(white: 0.95, alpha: 1)
        loginInput.layer.borderWidth = 1
        loginInput.layer.borderColor = UIColor.lightGray.cgColor
        loginInput.layer.cornerRadius = 5
        
        let userIconView = UIImageView(image: UIImage(systemName: "person"))
        userIconView.contentMode = .scaleAspectFit
        userIconView.tintColor = .lightGray
        userIconView.translatesAutoresizingMaskIntoConstraints = false
        userIconView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        loginInput.leftView = userIconView
        loginInput.leftViewMode = .always
        
        loginInput.rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 20, height: 40)))
        loginInput.rightViewMode = .always
        
        loginInput.translatesAutoresizingMaskIntoConstraints = false
        loginInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupPasswordInput() {
        
        passwordInput.placeholder = "Пароль"
        passwordInput.isSecureTextEntry = true
        passwordInput.autocapitalizationType = .none
        passwordInput.font = .systemFont(ofSize: 17)
        passwordInput.textColor = .darkGray
        passwordInput.backgroundColor = UIColor(white: 0.95, alpha: 1)
        passwordInput.layer.borderWidth = 1
        passwordInput.layer.borderColor = UIColor.lightGray.cgColor
        passwordInput.layer.cornerRadius = 5
        
        let lockIconView = UIImageView(image: UIImage(systemName: "lock"))
        lockIconView.contentMode = .scaleAspectFit
        lockIconView.tintColor = .lightGray
        lockIconView.translatesAutoresizingMaskIntoConstraints = false
        lockIconView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        passwordInput.leftView = lockIconView
        passwordInput.leftViewMode = .always
        
        passwordInput.rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 20, height: 40)))
        passwordInput.rightViewMode = .always
        
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func setupLoginButton() {
        
        loginButton.layer.cornerRadius = 5
        
        let normalColor = UIColor(red: 76/255, green: 117/255, blue: 163/255, alpha: 1)
        let highlightedColor = normalColor.withAlphaComponent(0.8)
        
        loginButton.setBackgroundColor(normalColor, for: .normal)
        loginButton.setBackgroundColor(highlightedColor, for: .highlighted)
        
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Войти", for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        
        loginButton.addTarget(self, action: #selector(handleLoginButtonTap), for: .touchUpInside)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

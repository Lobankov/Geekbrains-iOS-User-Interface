//
//  LoginVC.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 02.12.2020.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: Private fields
    
    private var keyboardIsVisible: Bool = false
    
    // MARK: UI Components
    
    private var formStackView: UIStackView!
    private var inputsStackView: UIStackView!
    private var wrongLoginLabel: UILabel!
    private var loginInput: UITextField!
    private var passwordInput: UITextField!
    private var showPasswordButton: UIButton!
    private var loginButton: UIButton!
    
    // MARK: Constraints
    
    /// Constraint that controls the Y-axis position of form stack view
    /// - Note: Nice and long name :D
    /// - Remark: We will tweak it's constant value in order to animate Y-axis of formStackView
    private var formStackViewCenterYConstraint: NSLayoutConstraint!
    
    private var wrongLoginBottomConstraint: NSLayoutConstraint!
    
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        formStackView = UIStackView()
        inputsStackView = UIStackView()
        wrongLoginLabel = UILabel()
        loginInput = UITextField()
        passwordInput = UITextField()
        loginButton = UIButton()
        
        view.addSubview(formStackView)
        view.addSubview(wrongLoginLabel)
        
        formStackView.addArrangedSubview(inputsStackView)
        
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = AppColors.border
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsStackView.addArrangedSubview(loginInput)
        inputsStackView.addArrangedSubview(separatorView)
        inputsStackView.addArrangedSubview(passwordInput)
        
        formStackView.addArrangedSubview(loginButton)
        
        setupFormStackView()
        setupWrongLoginLabel()
        setupInputsStackView()
        setupLoginInput()
        setupPasswordInput()
        setupLoginButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // subscribe to keyboard show and hide events...
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // unsubscribe from keyboard events, we no longer need them
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Control handlers
    
    @objc private func handleLoginButtonTap() {
        
        guard let login = loginInput.text, passwordInput.text?.isEmpty == false else {
            return
        }
        
        if login.isValidEmail() || login.isValidPhoneNumber() {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRoot(viewController: HomeTabBarVC())
        } else {
            showWrongLoginLabel()
        }
    }
    
    // MARK: Helper functions
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func togglePasswordVisibility() {
        
        let passwordWasHidden = passwordInput.isSecureTextEntry
        
        if passwordWasHidden {
            showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
        
        passwordInput.isSecureTextEntry.toggle()
        
    }
    
    private func showWrongLoginLabel() {
        
        wrongLoginBottomConstraint.constant = -10
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
    }
    
    private func hideWrongLoginLabel() {
        
        wrongLoginBottomConstraint.constant = 16
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    // MARK: Keyboard Event Handlers
    
    @objc private func keyboardWillShow(notification: Notification) {
        
        guard !keyboardIsVisible else {
            return
        }
        
        keyboardIsVisible.toggle()
        
        animateFormStackViewYConstraint(from: notification, show: true)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        
        guard keyboardIsVisible else {
            return
        }
        
        keyboardIsVisible.toggle()
        
        animateFormStackViewYConstraint(from: notification, show: false)
    }
    
    private func animateFormStackViewYConstraint(from notification: Notification, show: Bool) {
        
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
           let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
           let curveValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int {
            
            // create animator object with duration and curve that exactly match iOS keyboard show / hide animation. It will look great :)
            let animator = UIViewPropertyAnimator(duration: duration, curve: UIView.AnimationCurve(rawValue: curveValue)!, animations: nil)
            
            // if keyboard will show...
            if show {
                
                // get topmost view
                let rootView = UIApplication.shared.connectedScenes
                                        .filter({ $0.activationState == .foregroundActive })
                                        .map { $0 as? UIWindowScene }
                                        .compactMap { $0 }
                                        .first?.windows
                                        .filter { $0.isKeyWindow }
                                        .first?
                                        .rootViewController?.view
                
                // get keyboard frame in the root view
                let keyFrame = rootView!.convert(keyboardFrame.cgRectValue, to: rootView)
                // get formStackView frame in the root view
                let formFrame = formStackView.superview?.convert(formStackView.frame, to: rootView)
                
                // if these frames intersect each other...
                if keyFrame.intersects(formFrame!) {
                    // some nice vertical margin
                    let extraMargin: CGFloat = 20
                    // calculate exact offset that we need to use, in order to visibly see the login button just above the keyboard frame (with margin ofc)
                    let offset = abs(formFrame!.maxY - keyFrame.minY) + extraMargin
                    
                    // add animation block
                    animator.addAnimations { [weak self] in
                        self?.formStackViewCenterYConstraint.constant = -offset
                        self?.view.layoutIfNeeded()
                    }
                    // execute animation
                    animator.startAnimation()
                }
            }
            // if keyboard will hide...
            else {
                // we simply need to revert Y constraint constant back to zero
                animator.addAnimations { [weak self] in
                    self?.formStackViewCenterYConstraint.constant = 0
                    self?.view.layoutIfNeeded()
                }
                // execute animation block
                animator.startAnimation()
            }
        }
    }
    
    // MARK: Layout
    
    private func setupFormStackView() {
        
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        
        formStackView.layer.zPosition = 1
        formStackView.axis = .vertical
        formStackView.spacing = 5
        formStackView.distribution = .fill
        formStackView.alignment = .fill
        
        formStackView.setCustomSpacing(15, after: inputsStackView)
        
        // leading and trailing constraints must have less priority than width constraint.
        // this kind of a setup will force stackView to have 20 points padding from left and right in portrait mode,
        // but keep maximum width of 500 point in landscape, so it won't look ugly after rotating the phone :)
        
        let leadingConstraint = formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        leadingConstraint.priority = UILayoutPriority(rawValue: 998)
        
        let trailingConstraint = formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        trailingConstraint.priority = UILayoutPriority(rawValue: 998)
        
        let widthConstraint = formStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 500)
        widthConstraint.priority = UILayoutPriority(rawValue: 999)
        
        formStackViewCenterYConstraint = formStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            leadingConstraint,
            trailingConstraint,
            widthConstraint,
            formStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formStackViewCenterYConstraint
        ])
        
    }
    
    private func setupWrongLoginLabel() {
        
        wrongLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        
        wrongLoginLabel.font = .italicSystemFont(ofSize: 15)
        wrongLoginLabel.textColor = AppColors.darkRed
        wrongLoginLabel.text = "Неверный логин или пароль"
        
        let labelHeight: CGFloat = 16
        
        wrongLoginBottomConstraint = wrongLoginLabel.bottomAnchor.constraint(equalTo: formStackView.topAnchor, constant: labelHeight)
        
        NSLayoutConstraint.activate([
            wrongLoginBottomConstraint,
            wrongLoginLabel.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor, constant: 15),
            wrongLoginLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }
    
    private func setupInputsStackView() {
        
        inputsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        inputsStackView.axis = .vertical
        inputsStackView.distribution = .fill
        inputsStackView.alignment = .fill
        
        inputsStackView.clipsToBounds = true
        
        inputsStackView.layer.borderWidth = 1
        inputsStackView.layer.borderColor = UIColor(white: 0.85, alpha: 1).cgColor
        inputsStackView.layer.cornerRadius = 10
    }
    
    private func setupLoginInput() {
        
        // predefined dummy data
        loginInput.text = "alesha@geekbrains.ru"
        
        loginInput.delegate = self
        loginInput.autocapitalizationType = .none
        loginInput.font = .systemFont(ofSize: 16)
        loginInput.textColor = .black
        loginInput.backgroundColor = AppColors.lightGray
        loginInput.attributedPlaceholder = NSAttributedString(string: "Email или телефон", attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholder])
        
        loginInput.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 15, height: 40)))
        loginInput.leftViewMode = .always
        
        loginInput.rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 15, height: 40)))
        loginInput.rightViewMode = .always
        
        loginInput.translatesAutoresizingMaskIntoConstraints = false
        loginInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupPasswordInput() {
        
        // predefined dummy data
        passwordInput.text = "SuperSequrePassword1337"

        passwordInput.delegate = self
        passwordInput.isSecureTextEntry = true
        passwordInput.autocapitalizationType = .none
        passwordInput.font = .systemFont(ofSize: 16)
        passwordInput.textColor = .black
        passwordInput.backgroundColor = AppColors.lightGray
        passwordInput.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholder])
        
        passwordInput.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 15, height: 40)))
        passwordInput.leftViewMode = .always
        
        showPasswordButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
        showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        showPasswordButton.imageView?.contentMode = .scaleAspectFit
        showPasswordButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        showPasswordButton.contentHorizontalAlignment = .right
        showPasswordButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        showPasswordButton.tintColor = AppColors.placeholder
        showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        passwordInput.rightView = showPasswordButton
        passwordInput.rightViewMode = .whileEditing
        
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func setupLoginButton() {
        
        loginButton.layer.cornerRadius = 10
        
        let normalColor = AppColors.blue
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

extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideWrongLoginLabel()
    }
    
}

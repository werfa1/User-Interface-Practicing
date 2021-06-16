//
//  ViewController.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 15.06.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Variables
    
    private var loginView = UIView()
    private var loginLabel = UILabel()
    private var titleLabel = UILabel()
    private var loginTextField = UITextField()
    private var loginButton = UIButton()
    
    //MARK: - Functions
    
    @objc
    private func handleLogin(_ sender: UITapGestureRecognizer) {
        let spinningAnimator = UIActivityIndicatorView()
        spinningAnimator.center = loginView.center
        loginView.addSubview(spinningAnimator)
        spinningAnimator.style = .large
        spinningAnimator.color = .blue
        loginLabel.isHidden = true
        loginTextField.isHidden = true
        spinningAnimator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            spinningAnimator.stopAnimating()
            spinningAnimator.alpha = 0
            self.loginLabel.isHidden = false
            self.loginTextField.isHidden = false
        }
    }

    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Main window
        loginView.frame.size = CGSize(width: view.frame.size.width / 2, height: view.frame.size.height / 4)
        loginView.center = view.center
        loginView.backgroundColor = .white
        loginView.layer.cornerRadius = 5.0
        
        view.addSubview(loginView)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        //Top label
        titleLabel.text = "Login to access your account"
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        
        loginView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 15.0),
            titleLabel.centerXAnchor.constraint(equalTo: loginView.centerXAnchor)
        ])
        
        //Login label
        loginLabel.text = "Login"
        loginLabel.textAlignment = .center
        
        loginView.addSubview(loginLabel)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10.0),
            loginLabel.centerYAnchor.constraint(equalTo: loginView.centerYAnchor)
        ])
        
        //TextField to enter login
        loginTextField.delegate = self
        loginTextField.placeholder = "Enter your email/phone number"
        loginTextField.layer.borderWidth = 1.5
        loginTextField.textAlignment = .left
        loginTextField.autocapitalizationType = .none
        loginTextField.backgroundColor = .systemGray5
        loginTextField.returnKeyType = .done
        loginTextField.autocorrectionType = .no
        loginTextField.sizeToFit()
         
        loginView.addSubview(loginTextField)
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: loginLabel.trailingAnchor, constant: 20.0),
            loginTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            loginTextField.centerYAnchor.constraint(equalTo: loginView.centerYAnchor)
        ])
        
        //Button to log in
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLogin)))
        
        loginView.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor),
            loginButton.widthAnchor.constraint(equalTo: loginView.widthAnchor, multiplier: 0.3)
        ])
    }
}

//MARK: - Extensions

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

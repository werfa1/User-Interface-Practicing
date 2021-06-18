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
    private var passwordLabel = UILabel()
    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    private var correctLoginLabel = UILabel()
    private var loginButton = UIButton()
    private var loginInfo = ["":""]
    let spinningAnimator = UIActivityIndicatorView()
    
    //MARK: - Functions
    
    /// Checks if the input infor matches the loginInfo
    private func displayLoginResult(infoIsCorrect check: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
            guard let self = self else { return }
            self.spinningAnimator.stopAnimating()
            self.spinningAnimator.alpha = 0
            self.loginLabel.isHidden = false
            self.loginTextField.isHidden = false
            self.passwordLabel.isHidden = false
            self.passwordTextField.isHidden = false
            if check {
                let tabBarVc = TabBarViewController()
                tabBarVc.modalPresentationStyle = .fullScreen
                self.present(tabBarVc, animated: true, completion: nil)
            } else {
                self.correctLoginLabel.alpha = 1.0
                self.correctLoginLabel.text = "Wrong login/password"
                self.correctLoginLabel.textColor = .red
            }
        }
    }
    
    @objc
    private func handleLogin(_ sender: UITapGestureRecognizer) {
        correctLoginLabel.alpha = 0.0
        spinningAnimator.alpha = 1.0
        spinningAnimator.center = loginView.center
        loginView.addSubview(spinningAnimator)
        spinningAnimator.style = .large
        spinningAnimator.color = .blue
        loginLabel.isHidden = true
        loginTextField.isHidden = true
        passwordLabel.isHidden = true
        passwordTextField.isHidden = true
        spinningAnimator.startAnimating()
        
        let inputInforDictionary = ["\(loginTextField.text ??  "")":"\(passwordTextField.text ?? "")"]
        
        displayLoginResult(infoIsCorrect: NSDictionary(dictionary: loginInfo).isEqual(to: inputInforDictionary))
    }
    
    /// Configures the section which includes login and password sections + their labels
    private func configureLoginSection() {
        
        //Login label
        loginLabel.text = "Login"
        loginLabel.textAlignment = .left
        loginLabel.sizeToFit()
        loginView.addSubview(loginLabel)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10.0),
            loginLabel.centerYAnchor.constraint(equalTo: loginView.centerYAnchor)
        ])
        
        
        //Password label
        passwordLabel.text = "Password"
        passwordLabel.textAlignment = .left
        passwordLabel.sizeToFit()
        loginView.addSubview(passwordLabel)
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10.0),
            passwordLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20.0)
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
            loginTextField.centerYAnchor.constraint(equalTo: loginView.centerYAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -20.0),
            loginTextField.leadingAnchor.constraint(equalTo: loginLabel.trailingAnchor, constant: 52.5)
//            loginTextField.widthAnchor.constraint(equalTo: loginView.widthAnchor, multiplier: 0.5)
        ])
        
        
        //TextField to enter password
        passwordTextField.delegate = self
        passwordTextField.placeholder = "Enter password"
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.textAlignment = .left
        passwordTextField.autocapitalizationType = .none
        passwordTextField.backgroundColor = .systemGray5
        passwordTextField.returnKeyType = .done
        passwordTextField.autocorrectionType = .no
        passwordTextField.sizeToFit()
        loginView.addSubview(passwordTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.trailingAnchor, constant: 20.0),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20.0),
            passwordTextField.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -20.0)
//            passwordTextField.widthAnchor.constraint(equalTo: loginView.widthAnchor, multiplier: 0.5)
        ])
    }

    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Main window
        loginView.frame.size = CGSize(width: view.frame.size.width / 2, height: view.frame.size.height / 4)
        loginView.center = view.center
        loginView.backgroundColor = .white
        view.addSubview(loginView)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        //See description
        configureLoginSection()
        
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
        
        
        //Label whick checks whether the login info is correct
        correctLoginLabel.alpha = 0.0
        correctLoginLabel.textAlignment = .center
        correctLoginLabel.sizeToFit()
        loginView.addSubview(correctLoginLabel)
        
        correctLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            correctLoginLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20.0),
            correctLoginLabel.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
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

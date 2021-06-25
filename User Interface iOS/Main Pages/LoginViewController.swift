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
    
    private let shapeLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()

    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureLoginView()
        configureTopLabel()
        configureLoginSection()
        configureCorrectLoginLabel()
        configureLoginButton()
    }
    
    //MARK: - Functions
    
    @objc
    private func handleLogin(_ sender: UITapGestureRecognizer) {
        correctLoginLabel.alpha     = 0.0
        loginLabel.isHidden         = true
        loginTextField.isHidden     = true
        passwordLabel.isHidden      = true
        passwordTextField.isHidden  = true
        loginButton.isHidden        = true
        
        let inputInforDictionary = ["\(loginTextField.text ??  "")":"\(passwordTextField.text ?? "")"]
        
        displayLoginResult(infoIsCorrect: NSDictionary(dictionary: loginInfo).isEqual(to: inputInforDictionary))
    }
    
    /// Checks if the input infor matches the loginInfo
    private func displayLoginResult(infoIsCorrect check: Bool) {
        loadLoginAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
            guard let self = self else { return }
            if check {
                let tabBarVc                        = TabBarViewController()
                tabBarVc.modalPresentationStyle     = .fullScreen
                self.present(tabBarVc, animated: true, completion: nil)
            } else {
                self.loginLabel.isHidden            = false
                self.loginTextField.isHidden        = false
                self.passwordLabel.isHidden         = false
                self.passwordTextField.isHidden     = false
                self.loginButton.isHidden           = false
                
                self.shapeLayer.isHidden            = true
                self.trackLayer.isHidden            = true
                
                self.correctLoginLabel.alpha        = 1.0
                self.correctLoginLabel.text         = "Wrong login/password"
                self.correctLoginLabel.textColor    = .red
                
            }
        }
    }
    
    private func loadLoginAnimation () {
        self.shapeLayer.isHidden            = false
        self.trackLayer.isHidden            = false
        
        let center = view.center
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 30, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.fillColor = UIColor.white.cgColor
        trackLayer.lineWidth = 1
                
        shapeLayer.path = circularPath.cgPath
        view.layer.addSublayer(trackLayer)
        
        //Creating a loading layer
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.duration = 1
        basicAnimation.toValue = 1
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
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
        ])
    }
    
    private func configureLoginButton() {
        //Button to log in
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLogin)))
        loginButton.layer.cornerRadius = 5
        loginView.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            loginButton.widthAnchor.constraint(equalTo: loginView.widthAnchor, multiplier: 0.75)
        ])
    }
    
    /// Configures the label which is displayed if the login info is not correct
    private func configureCorrectLoginLabel() {
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
    }
    
    private func configureTopLabel () {
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
    }
    
    private func configureLoginView() {
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
    }
}

//MARK: - Extensions

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

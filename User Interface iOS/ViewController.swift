//
//  ViewController.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 15.06.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let loginView = UIView()
        loginView.frame.size = CGSize(width: view.frame.size.width / 2, height: view.frame.size.height / 4)
        loginView.center = view.center
        loginView.backgroundColor = .purple
        
        view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            loginView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        view.layoutIfNeeded()
        
    }

}


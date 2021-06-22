//
//  PersonalPageVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 22.06.2021.
//

import UIKit

class PersonalPageVC: UIViewController {

    //MARK: - Variables
    
    var profilePicImageView = UIImageView()
    var personalNameLabel = UILabel()
    var statusLabel = UILabel()
    
    //MARL: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .white
        configureProfilePic()
        configurePersonalName()
    }
    
    //MARK: - Functions
    
    private func configureProfilePic () {
        
        /// Container view to make shadow visible
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: view.frame.size.width / 3))
        outerView.clipsToBounds         = false
        outerView.layer.shadowColor     = UIColor.black.cgColor
        outerView.layer.shadowOpacity   = 1
        outerView.layer.shadowOffset    = CGSize.zero
        outerView.layer.shadowRadius    = 10
        outerView.layer.shadowPath      = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: outerView.frame.size.width / 2).cgPath
        
        view.addSubview(outerView)
        
        outerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            outerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            outerView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3),
            outerView.heightAnchor.constraint(equalTo: outerView.widthAnchor)
        ])
        
        // Profile picture itself
        profilePicImageView.backgroundColor = .white
        profilePicImageView.contentMode     = .scaleAspectFill
        profilePicImageView.frame           = outerView.frame
        profilePicImageView.image           = UIImage(named: "rock")
        outerView.addSubview(profilePicImageView)

        //Making imageView circular
        profilePicImageView.layer.borderWidth   = 5.0
        profilePicImageView.layer.masksToBounds = false
        profilePicImageView.layer.borderColor   = UIColor.white.cgColor
        profilePicImageView.layer.cornerRadius  = outerView.frame.size.width / 2 //This divider should be 0.5 of widthAnchor constraint divider
        profilePicImageView.clipsToBounds       = true
        profilePicImageView.layer.shadowRadius  = 5
        profilePicImageView.layer.shadowColor   = UIColor.black.cgColor
    }
    
    private func configurePersonalName () {
        personalNameLabel.text                      = "Dwayne 'The Rock' Johnson"
        personalNameLabel.numberOfLines             = 0
        personalNameLabel.adjustsFontSizeToFitWidth = true
        personalNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(personalNameLabel)
        
        personalNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personalNameLabel.leadingAnchor.constraint(equalTo: (profilePicImageView.superview?.trailingAnchor)!, constant: 16),
            personalNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            personalNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            personalNameLabel.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}

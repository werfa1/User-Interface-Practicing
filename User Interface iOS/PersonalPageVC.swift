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
    }
    
    //MARK: - Functions
    
    private func configureProfilePic () {
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 10
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: outerView.frame.size.width / 2).cgPath
//        outerView.layer.cornerRadius = outerView.frame.size.width / 2
        
        view.addSubview(outerView)
        
        outerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            outerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            outerView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3),
            outerView.heightAnchor.constraint(equalTo: outerView.widthAnchor)
        ])
        
        profilePicImageView.backgroundColor = .white
        profilePicImageView.contentMode = .scaleAspectFill
        profilePicImageView.frame = outerView.frame
        profilePicImageView.image = UIImage(named: "rock")
        outerView.addSubview(profilePicImageView)

//        profilePicImageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            profilePicImageView.leadingAnchor.constraint(equalTo: outerView.leadingAnchor),
//            profilePicImageView.topAnchor.constraint(equalTo: outerView.topAnchor),
//            profilePicImageView.trailingAnchor.constraint(equalTo: outerView.trailingAnchor),
//            profilePicImageView.bottomAnchor.constraint(equalTo: outerView.bottomAnchor)
//        ])

        //Making imageView circular
        profilePicImageView.layer.borderWidth = 5.0
        profilePicImageView.layer.masksToBounds = false
        profilePicImageView.layer.borderColor = UIColor.white.cgColor
        profilePicImageView.layer.cornerRadius = outerView.frame.size.width / 2 //This divider should be 0.5 of widthAnchor constraint divider
        profilePicImageView.clipsToBounds = true
        profilePicImageView.layer.shadowRadius = 5
        profilePicImageView.layer.shadowColor = UIColor.black.cgColor
        
        
        
    }
    
    private func configurePersonalName () {
        personalNameLabel.text = "The Greatest"
    }

}

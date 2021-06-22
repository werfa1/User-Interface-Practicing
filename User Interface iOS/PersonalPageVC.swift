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
        
        profilePicImageView.backgroundColor = .white
        profilePicImageView.contentMode = .scaleAspectFill
        profilePicImageView.frame.size = CGSize(width: 100, height: 100)
        profilePicImageView.image = UIImage(named: "random-dude")
        view.addSubview(profilePicImageView)
        
        //Making imageView circular
        profilePicImageView.layer.borderWidth = 1.0
        profilePicImageView.layer.masksToBounds = false
        profilePicImageView.layer.borderColor = UIColor.white.cgColor
        profilePicImageView.layer.cornerRadius = profilePicImageView.frame.size.width / 1.5 //Divider should be 0.5 of widthAnchor constraint divider
        profilePicImageView.clipsToBounds = true
        
        profilePicImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePicImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profilePicImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profilePicImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3),
            profilePicImageView.heightAnchor.constraint(equalTo: profilePicImageView.widthAnchor)
        ])
    }

}

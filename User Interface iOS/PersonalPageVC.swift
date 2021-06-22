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
        view.backgroundColor = .cyan
        configureProfilePic()
    }
    
    //MARK: - Functions
    
    private func configureProfilePic () {
        
        profilePicImageView.layer.borderWidth = 1.0
        profilePicImageView.layer.masksToBounds = false
        profilePicImageView.layer.borderColor = UIColor.white.cgColor
        profilePicImageView.layer.cornerRadius = profilePicImageView.frame.size.width / 2
        profilePicImageView.clipsToBounds = true
        profilePicImageView.contentMode = .scaleAspectFill
        profilePicImageView.frame.size = CGSize(width: 100, height: 100)
        profilePicImageView.image = UIImage(systemName: "person.fill")
        view.addSubview(profilePicImageView)
        
        profilePicImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePicImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            profilePicImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profilePicImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 4),
            profilePicImageView.heightAnchor.constraint(equalTo: profilePicImageView.widthAnchor)
        ])
    }

}

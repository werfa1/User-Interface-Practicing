//
//  FriendCellTableViewCell.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit

class FriendCell: UITableViewCell {
    
    //MARK: - Variables
    static let identifier = "FriendCell"
    
    var userName = UILabel()
    var userProfilePic = UIImageView()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(userName)
        addSubview(userProfilePic)
        
        configureLabel()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func configureCell(WithUser user: User) {
        self.userName.text = user.userName
        self.userProfilePic.image = UIImage(named: user.userProfilePicture)
    }
    
    private func configureImageView() {
        userProfilePic.layer.cornerRadius = 10
        userProfilePic.clipsToBounds      = true
        
        userProfilePic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userProfilePic.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            userProfilePic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            userProfilePic.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(self.frame.size.width - 15.0)),
            userProfilePic.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func configureLabel() {
        userName.numberOfLines             = 0
        userName.adjustsFontSizeToFitWidth = true
        
        userName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userName.centerYAnchor.constraint(equalTo: centerYAnchor),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor),
            userName.leadingAnchor.constraint(equalTo: userProfilePic.trailingAnchor, constant: 15.0),
            userName.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//
//  CommunityCell.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit

class CommunityCell: UITableViewCell {
    
    //MARK: - Variables
    static let identifier = "CommunityCell"

    var communityName = UILabel()
    var communityProfilePic = UIImageView()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(communityName)
        addSubview(communityProfilePic)
        
        configureLabel()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func configureCell(WithGroup group: Group) {
        self.communityName.text = group.groupName
        self.communityProfilePic.image = UIImage(named: group.groupProfilePic)
    }
    
    private func configureImageView() {
        communityProfilePic.layer.cornerRadius = 20
        communityProfilePic.clipsToBounds      = true
        
        communityProfilePic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            communityProfilePic.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            communityProfilePic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            communityProfilePic.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(self.frame.size.width - 15.0)),
            communityProfilePic.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func configureLabel() {
        communityName.numberOfLines             = 0
        communityName.adjustsFontSizeToFitWidth = true
        
        communityName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            communityName.centerYAnchor.constraint(equalTo: centerYAnchor),
            communityName.trailingAnchor.constraint(equalTo: trailingAnchor),
            communityName.leadingAnchor.constraint(equalTo: communityProfilePic.trailingAnchor, constant: 15.0),
            communityName.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

//
//  GroupCell.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 17.06.2021.
//

import UIKit

class GroupCell: UITableViewCell {
    
    //MARK: - Variables
    static let identifier = "GroupCell"

    var groupName = UILabel()
    var groupProfilePic = UIImageView()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(groupName)
        addSubview(groupProfilePic)
        
        configureLabel()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func configureCell(WithGroup group: Group) {
        self.groupName.text = group.groupName
        self.groupProfilePic.image = UIImage(named: group.groupProfilePic)
    }
    
    private func configureImageView() {
        groupProfilePic.layer.cornerRadius = 20
        groupProfilePic.clipsToBounds      = true
        
        groupProfilePic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupProfilePic.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            groupProfilePic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            groupProfilePic.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(self.frame.size.width - 25.0)),
            groupProfilePic.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func configureLabel() {
        groupName.numberOfLines             = 0
        groupName.adjustsFontSizeToFitWidth = true
        
        groupName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupName.centerYAnchor.constraint(equalTo: centerYAnchor),
            groupName.trailingAnchor.constraint(equalTo: trailingAnchor),
            groupName.leadingAnchor.constraint(equalTo: groupProfilePic.trailingAnchor, constant: 15.0),
            groupName.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

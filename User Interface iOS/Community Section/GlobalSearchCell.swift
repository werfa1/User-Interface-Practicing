//
//  GlobalSearchCell.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 18.06.2021.
//

import UIKit

class GlobalSearchCell: UITableViewCell {
    
    //MARK: - Variables
    
    static let identifier = "GlobalSearchCell"

    var globalGroupName = UILabel()
    var globalGroupProfilePic = UIImageView()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(globalGroupName)
        addSubview(globalGroupProfilePic)
        
        configureLabel()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func configureCell(withGroup group: Group) {
        self.globalGroupName.text = group.groupName
        self.globalGroupProfilePic.image = UIImage(named: group.groupProfilePic)
    }
    
    private func configureImageView() {
        globalGroupProfilePic.layer.cornerRadius = 20
        globalGroupProfilePic.clipsToBounds      = true
        
        globalGroupProfilePic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            globalGroupProfilePic.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            globalGroupProfilePic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            globalGroupProfilePic.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(self.frame.size.width - 25.0)),
            globalGroupProfilePic.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func configureLabel() {
        globalGroupName.numberOfLines             = 0
        globalGroupName.adjustsFontSizeToFitWidth = true
        
        globalGroupName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            globalGroupName.centerYAnchor.constraint(equalTo: centerYAnchor),
            globalGroupName.trailingAnchor.constraint(equalTo: trailingAnchor),
            globalGroupName.leadingAnchor.constraint(equalTo: globalGroupProfilePic.trailingAnchor, constant: 15.0),
            globalGroupName.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

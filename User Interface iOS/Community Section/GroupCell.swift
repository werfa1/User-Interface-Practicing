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
        
        configureImageView()
        configureLabel()
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
        groupProfilePic.layer.cornerRadius = 10
        groupProfilePic.clipsToBounds      = true
        groupProfilePic.isUserInteractionEnabled = true
        groupProfilePic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        contentView.addSubview(groupProfilePic)
        
        groupProfilePic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupProfilePic.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            groupProfilePic.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            groupProfilePic.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(self.frame.size.width - 25.0)),
            groupProfilePic.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func configureLabel() {
        groupName.numberOfLines             = 0
        groupName.adjustsFontSizeToFitWidth = true
        contentView.addSubview(groupName)
        
        groupName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            groupName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            groupName.leadingAnchor.constraint(equalTo: groupProfilePic.trailingAnchor, constant: 15.0),
            groupName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc
    private func handleTap (_ sender: UITapGestureRecognizer) {
        
        switch sender.state {
        case .ended, .cancelled, .failed:
            UIView.animate(withDuration: 0.3) {
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.groupProfilePic.transform = scale
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    let scale = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    self.groupProfilePic.transform = scale
                } completion: { _ in
                    UIView.animate(withDuration: 0.2) {
                        let scale = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        self.groupProfilePic.transform = scale
                    } completion: { _ in
                        UIView.animate(withDuration: 0.2) {
                            let scale = CGAffineTransform(scaleX: 1.05, y: 1.05)
                            self.groupProfilePic.transform = scale
                        } completion: { _ in
                            UIView.animate(withDuration: 0.1) {
                                let scale = CGAffineTransform(scaleX: 0.95, y: 0.95)
                                self.groupProfilePic.transform = scale
                            } completion: { _ in
                                UIView.animate(withDuration: 0.1) {
                                    let scale = CGAffineTransform(scaleX: 1.025, y: 1.025)
                                    self.groupProfilePic.transform = scale
                                } completion: { _ in
                                    UIView.animate(withDuration: 0.1) {
                                        let scale = CGAffineTransform(scaleX: 0.975, y: 0.975)
                                        self.groupProfilePic.transform = scale
                                    } completion: { _ in
                                        UIView.animate(withDuration: 0.1) {
                                            let scale = CGAffineTransform(scaleX: 1, y: 1)
                                            self.groupProfilePic.transform = scale
                                        }
                                    }
                                }
                            } 
                        }
                    }
                }
            }
            
        default:
            break
        }
    }

}

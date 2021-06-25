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
        
        configureImageView()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func configureCell(WithUser user: Friend) {
        self.userName.text = user.friendName
        self.userProfilePic.image = UIImage(named: user.friendProfilePicture)
    }
    
    private func configureImageView() {
        userProfilePic.layer.cornerRadius       = 10
        userProfilePic.clipsToBounds            = true
        userProfilePic.isUserInteractionEnabled = true
        userProfilePic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        contentView.addSubview(userProfilePic)
        
        userProfilePic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userProfilePic.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userProfilePic.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            userProfilePic.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(self.frame.size.width - 25.0)),
            userProfilePic.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func configureLabel() {
        userName.numberOfLines             = 0
        userName.adjustsFontSizeToFitWidth = true
        contentView.addSubview(userName)
        
        userName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userName.centerYAnchor.constraint(equalTo: centerYAnchor),
            //userName.trailingAnchor.constraint(equalTo: trailingAnchor),
            userName.leadingAnchor.constraint(equalTo: userProfilePic.trailingAnchor, constant: 15.0),
            userName.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc
    private func handleTap (_ sender: UITapGestureRecognizer) {
        
        switch sender.state {
        case .ended, .cancelled, .failed:
            UIView.animate(withDuration: 0.3) {
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.userProfilePic.transform = scale
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    let scale = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    self.userProfilePic.transform = scale
                } completion: { _ in
                    UIView.animate(withDuration: 0.3) {
                        let scale = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        self.userProfilePic.transform = scale
                    } completion: { _ in
                        UIView.animate(withDuration: 0.3) {
                            let scale = CGAffineTransform(scaleX: 1.05, y: 1.05)
                            self.userProfilePic.transform = scale
                        } completion: { _ in
                            UIView.animate(withDuration: 0.3) {
                                let scale = CGAffineTransform(scaleX: 0.95, y: 0.95)
                                self.userProfilePic.transform = scale
                            } completion: { _ in
                                UIView.animate(withDuration: 0.3) {
                                    let scale = CGAffineTransform(scaleX: 1, y: 1)
                                    self.userProfilePic.transform = scale
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

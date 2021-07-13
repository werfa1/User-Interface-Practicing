//
//  PhotoCell.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 21.06.2021.
//

import UIKit
import Gemini

class PhotoCell: GeminiCell {
    
    //MARK: - Variables
    
    static let identifier = "PhotoCell"
    
    private var imageView = UIImageView()
    
    private var likeButton = UIButton()
    
    //Checks if the like button is tapped
    private var isLiked = false
    
    private var likeCountLabel = UILabel()
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureImageView()
        configureLikeButton()
        configureLikeCountLabel()
        
        self.clipsToBounds = true
        backgroundColor = .white
    }
    
    //MARK: - Functions
    
    private func configureImageView () {
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -50)
        ])
    }
    
    private func configureLikeButton () {
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.clipsToBounds = true
        likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(likeButton)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.widthAnchor.constraint(equalToConstant: 50),
            likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            likeButton.topAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
    
    private func configureLikeCountLabel () {
        likeCountLabel.text             = ""
        likeCountLabel.numberOfLines    = 0
        likeCountLabel.alpha            = 0
        self.addSubview(likeCountLabel)
        
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            likeCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            likeCountLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor),
            likeCountLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        isLiked.toggle()
        sender.tintColor = isLiked ? .systemRed : .systemBlue
        UIView.animate(withDuration: 0.3) {
            if self.isLiked {
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            self.likeCountLabel.text    = self.isLiked ? "1 like": ""
            self.likeCountLabel.alpha   = self.isLiked ? 1 : 0
        } 
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

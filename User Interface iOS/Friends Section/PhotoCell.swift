//
//  PhotoCell.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 21.06.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
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
        //imageView.contentMode = .scaleAspectFill
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
        likeCountLabel.text = ""
        likeCountLabel.numberOfLines = 0
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
        if isLiked {
            //sender.setImage(UIImage(named: "fullHeart"), for: .normal)
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
//            sender.setImage(UIImage(named: "emptyHeart"), for: .normal)
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        likeCountLabel.text = isLiked ? "1 like": ""
        
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

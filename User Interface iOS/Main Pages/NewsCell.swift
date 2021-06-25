//
//  NewsCell.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 24.06.2021.
//

import UIKit

protocol LikedButtonTappedDelegate: AnyObject {
    func didTapLikeButton (photoIsLiked isLike: Bool)
}

class NewsCell: UITableViewCell {

    //MARK: - Variables
    
    static let identifier = "NewsCell"
    
    private var newsImageView = UIImageView()
    
    var likeButton = UIButton()
    
    weak var tappedLikeButtonDelegate: LikedButtonTappedDelegate?
    
    //Checks if the like button is tapped
    private var isLiked = false
    
    private var likeCountLabel = UILabel()
    
    private var commentButton = UIButton()
    
    private var shareButton = UIButton()
    
    private var eyeButton = UIButton()
    
    private var viewsCountLabel = UILabel()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        doUltimateConfiguration()
        isUserInteractionEnabled = true
        self.clipsToBounds = true
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    /// Calls all the configuration functions
    private func doUltimateConfiguration () {
        configureImageView()
        configureBottomPart()
        configureLikeButton()
        configureLikeCountLabel()
        configureCommentButton()
        configureShareButton()
        configureEyeButton()
        configureViewCountLabel()
    }
    
    private func configureImageView () {
        self.addSubview(newsImageView)
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: self.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -50)
        ])
    }
    
    private func configureLikeButton () {
        //Setting like button
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.clipsToBounds = true
        likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        //likeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeButtonPressedThroughGesture)))
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.widthAnchor.constraint(equalToConstant: 50),
            likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            likeButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor)
        ])
    }
    
    private func configureLikeCountLabel () {
        //Setting like count label
        likeCountLabel.text = "0 like"
        likeCountLabel.numberOfLines = 0
        likeCountLabel.isHidden = true
        
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            likeCountLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor),
            likeCountLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            likeCountLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureCommentButton () {
        commentButton.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            commentButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            commentButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureShareButton () {
        shareButton.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            shareButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor),
            shareButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureEyeButton () {
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eyeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            eyeButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            eyeButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureViewCountLabel() {
        viewsCountLabel.text = "0"
        viewsCountLabel.isHidden = false
        
        viewsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewsCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            viewsCountLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            viewsCountLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureBottomPart () {
        let emptyView = UIView()
        
        let hStack = UIStackView(arrangedSubviews: [likeButton, likeCountLabel, commentButton, shareButton, emptyView, eyeButton, viewsCountLabel])
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.isUserInteractionEnabled = true
                
        self.addSubview(hStack)
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.centerXAnchor.constraint(equalTo: newsImageView.centerXAnchor),
            hStack.topAnchor.constraint(equalTo: newsImageView.bottomAnchor)
        ])
        
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        isLiked.toggle()
        tappedLikeButtonDelegate?.didTapLikeButton(photoIsLiked: isLiked)
        if isLiked {
            sender.setImage(UIImage(named: "fullHeart"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "emptyHeart"), for: .normal)
        }
        
        likeCountLabel.text = isLiked ? "1 like": "0 like"
    }
    
    @objc private func likeButtonPressedThroughGesture (_ sender: UITapGestureRecognizer) {
        isLiked.toggle()
        guard let likeButton = sender.view as? UIButton else { return }
        if isLiked {
            likeButton.setImage(UIImage(named: "fullHeart"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
        }
        
        likeCountLabel.text = isLiked ? "1 like": "0 like"
    }
    
    func configure(with image: UIImage) {
        newsImageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

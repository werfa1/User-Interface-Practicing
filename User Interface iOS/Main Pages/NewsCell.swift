//
//  NewsCell.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 24.06.2021.
//

import UIKit

class NewsCell: UITableViewCell {

    //MARK: - Variables
    
    static let identifier = "NewsCell"
    
    private var newsImageView = UIImageView()
    
    var likeButton = UIButton()
        
    //Checks if the like button is tapped
    private var isLiked = false
    
    private var likeCountLabel = UILabel()
    
    private var commentButton = UIButton()
    
    private var shareButton = UIButton()
    
    private var eyeButton = UIButton()
    
    private var viewsCountLabel = UILabel()
    
    private var topLabel = UILabel()
    
    private let bottomButtonSize: CGFloat = 40
    
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        doUltimateConfiguration()
        self.clipsToBounds = true
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    /// Calls all the configuration functions
    private func doUltimateConfiguration () {
        configureTopLabel()
        configureImageView()
        configureBottomPart()
        configureLikeButton()
        configureLikeCountLabel()
        configureCommentButton()
        configureShareButton()
        configureEyeButton()
        configureViewCountLabel()
    }
    
    private func configureTopLabel() {
        topLabel.text = "Haha funny label go brrrrr"
        contentView.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            topLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: bottomButtonSize)
        ])
    }
    
    private func configureImageView () {
        self.addSubview(newsImageView)
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
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
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.widthAnchor.constraint(equalToConstant: bottomButtonSize),
            likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            likeButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor)
        ])
    }
    
    private func configureLikeCountLabel () {
        //Setting like count label
        likeCountLabel.text = ""
        likeCountLabel.numberOfLines = 0
        likeCountLabel.isHidden = true
        
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            likeCountLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor),
            likeCountLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            likeCountLabel.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func configureCommentButton () {
        commentButton.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            commentButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            commentButton.widthAnchor.constraint(equalToConstant: bottomButtonSize)
        ])
    }
    
    private func configureShareButton () {
        shareButton.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            shareButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor),
            shareButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: bottomButtonSize)
        ])
    }
    
    private func configureEyeButton () {
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eyeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            eyeButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            eyeButton.widthAnchor.constraint(equalToConstant: bottomButtonSize)
        ])
    }
    
    private func configureViewCountLabel() {
        viewsCountLabel.text = "0"
        
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
                
        contentView.addSubview(hStack)
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.centerXAnchor.constraint(equalTo: newsImageView.centerXAnchor),
            hStack.topAnchor.constraint(equalTo: newsImageView.bottomAnchor)
        ])
        
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        isLiked.toggle()
        UIView.animate(withDuration: 0.3) {
            if self.isLiked {
                self.likeCountLabel.isHidden = false
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.likeCountLabel.text = "1"
            } else {
                self.likeCountLabel.isHidden = true
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
                self.likeCountLabel.text = ""
            }
        }
    }
    
    func configure(with image: UIImage) {
        newsImageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func prepareForReuse() {
        viewsCountLabel.text = "\(Int(viewsCountLabel.text!)! + 1)"
        isLiked = false
    }
}

